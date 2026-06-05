#!/usr/bin/env python3
import os
import sys
import re
import requests
from datetime import datetime, timedelta
from typing import List, Dict, Optional, Tuple

# Configuración
KANBOARD_URL = "http://localhost/jsonrpc.php"
KANBOARD_USER = "jsonrpc"
KANBOARD_PASSWORD = "008dff17cf883361b574950ce81f0f0cc4881cf2901fed4f41ca8f1c4a77"

PROJECT_NAME = "EduQuiz"
DEFAULT_COLUMN = "Backlog"
INITIAL_BASE_DATE = datetime(2026, 6, 28)   # Fecha de inicio de la primera sección (Setup)
ADMIN_USER_ID = 1
PROJECT_ROLE_MANAGER = 1

# Definir grupos de secciones que se ejecutan en paralelo (índices 0-based)
# Las secciones fuera de estos grupos se ejecutan secuencialmente.
# Ejemplo: paralelizar Frontend (índice 1) y Backend (índice 2)
parallel_groups = [
    [1, 2]   # Secciones 2 (Frontend) y 3 (Backend) en paralelo
]

def parse_sections_from_md(file_path: str) -> List[Tuple[str, List[Dict]]]:
    """Lee el archivo Markdown y devuelve (nombre_seccion, lista_tareas) en el orden del archivo"""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
    except FileNotFoundError:
        print(f"❌ Archivo {file_path} no encontrado.")
        sys.exit(1)

    # Dividir por encabezados ## (asumimos que el primer ## es el título principal, lo saltamos)
    sections = re.split(r'\n##\s+', content)
    result = []
    for raw_section in sections[1:]:  # El primer elemento es el texto antes del primer ##
        lines = raw_section.split('\n')
        section_title = lines[0].strip()
        tasks = []
        current_task = {}
        for line in lines[1:]:
            line_stripped = line.strip()
            if line_stripped.startswith('- **Título:**'):
                if current_task and 'title' in current_task:
                    tasks.append(current_task)
                current_task = {}
                title_part = line_stripped.split('**Título:**')[-1].strip()
                if title_part.startswith('- '):
                    title_part = title_part[2:]
                current_task['title'] = title_part
            elif '**Descripción:**' in line_stripped:
                current_task['description'] = line_stripped.split('**Descripción:**')[-1].strip()
            elif '**Tags:**' in line_stripped:
                tags_str = line_stripped.split('**Tags:**')[-1].strip()
                tags_str = re.sub(r'[`"\']', '', tags_str)
                tags = [tag.strip() for tag in tags_str.split(',') if tag.strip()]
                current_task['tags'] = tags
            elif '**Color:**' in line_stripped:
                color = line_stripped.split('**Color:**')[-1].strip()
                current_task['color'] = color
            elif '**Duración:**' in line_stripped:
                dur_str = line_stripped.split('**Duración:**')[-1].strip()
                match = re.match(r'(\d+(?:\.\d+)?)d', dur_str)
                if match:
                    current_task['duration_days'] = float(match.group(1))
                else:
                    current_task['duration_days'] = 1.0
        if current_task and 'title' in current_task:
            tasks.append(current_task)

        # Añadir etiqueta de sección
        section_tag = re.sub(r'^\d+\.\s*', '', section_title).lower().replace(' ', '-')
        for task in tasks:
            if 'tags' not in task:
                task['tags'] = []
            if section_tag not in task['tags']:
                task['tags'].append(section_tag)
            if 'color' not in task:
                task['color'] = 'blue'
            if 'duration_days' not in task:
                task['duration_days'] = 1.0
        result.append((section_title, tasks))
    return result

def kanboard_rpc(method: str, params: dict) -> dict:
    payload = {"jsonrpc": "2.0", "method": method, "id": 1, "params": params}
    try:
        response = requests.post(
            KANBOARD_URL,
            json=payload,
            auth=(KANBOARD_USER, KANBOARD_PASSWORD),
            headers={"Content-Type": "application/json"}
        )
        response.raise_for_status()
        result = response.json()
        if "error" in result:
            raise Exception(f"Error JSON-RPC: {result['error']}")
        return result.get("result")
    except Exception as e:
        print(f"❌ Error en {method}: {e}")
        return None

def get_or_create_project(project_name: str) -> Optional[int]:
    projects = kanboard_rpc("getAllProjects", {})
    if projects is None:
        return None
    for p in projects:
        if p['name'] == project_name:
            print(f"📁 Proyecto existente: {project_name} (ID: {p['id']})")
            return p['id']
    print(f"🚀 Creando proyecto '{project_name}'...")
    project_id = kanboard_rpc("createProject", {"name": project_name})
    if project_id:
        print(f"✅ Proyecto creado con ID: {project_id}")
    return project_id

def add_admin_to_project(project_id: int):
    result = kanboard_rpc("addProjectUser", {
        "project_id": project_id,
        "user_id": ADMIN_USER_ID,
        "role": PROJECT_ROLE_MANAGER
    })
    if result:
        print(f"👤 Admin (ID {ADMIN_USER_ID}) agregado al proyecto.")
    else:
        print(f"⚠️ No se pudo agregar admin (quizás ya tiene permisos).")

def get_column_id(project_id: int, column_name: str) -> Optional[int]:
    columns = kanboard_rpc("getColumns", {"project_id": project_id})
    if not columns:
        return None
    for col in columns:
        if col['title'] == column_name:
            return col['id']
    return columns[0]['id'] if columns else None

def create_task(project_id: int, title: str, description: str, column_id: int, tags: List[str],
                date_start: str = None, date_due: str = None, color: str = None) -> Optional[int]:
    params = {
        "project_id": project_id,
        "title": title,
        "description": description,
        "column_id": column_id,
        "tags": tags
    }
    if date_start:
        params["date_started"] = date_start
    if date_due:
        params["date_due"] = date_due
    if color:
        params["color_id"] = color
    return kanboard_rpc("createTask", params)

def compute_section_end_date(tasks: List[Dict], start_date: datetime) -> datetime:
    """Dada una lista de tareas y una fecha de inicio, calcula la fecha de fin después de ejecutarlas secuencialmente."""
    current = start_date
    for task in tasks:
        duration = task.get('duration_days', 1.0)
        current += timedelta(days=duration)
    return current

def main():
    md_file = "TAREAS_KANBAN.md"   # Ajusta según el nombre real de tu archivo
    if not os.path.exists(md_file):
        parent_md = os.path.join("..", md_file)
        if os.path.exists(parent_md):
            md_file = parent_md
        else:
            # Intenta con nombres alternativos
            alt_names = ["TAREAS_KANBAN_v2.md", "TAREAS_KANBAN.md"]
            for alt in alt_names:
                if os.path.exists(alt):
                    md_file = alt
                    break
                parent_alt = os.path.join("..", alt)
                if os.path.exists(parent_alt):
                    md_file = parent_alt
                    break
            else:
                print(f"❌ No se encontró archivo de tareas (buscados: {alt_names})")
                sys.exit(1)

    print(f"🔌 Conectando a {KANBOARD_URL}")
    print(f"📄 Usando {md_file}")

    project_id = get_or_create_project(PROJECT_NAME)
    if not project_id:
        print("❌ No se pudo obtener/crear el proyecto.")
        sys.exit(1)

    add_admin_to_project(project_id)

    column_id = get_column_id(project_id, DEFAULT_COLUMN)
    if not column_id:
        print(f"❌ Columna '{DEFAULT_COLUMN}' no disponible.")
        sys.exit(1)

    sections = parse_sections_from_md(md_file)
    total_tasks = sum(len(tasks) for _, tasks in sections)
    print(f"📋 {total_tasks} tareas en {len(sections)} secciones.\n")

    # Fecha actual (inicio de la primera sección o grupo)
    current_date = INITIAL_BASE_DATE

    # Marcamos qué índices de sección ya fueron procesados
    processed = set()
    # Almacenamos las fechas de fin de cada sección (para luego calcular máximos)
    section_end_dates = [None] * len(sections)

    # Función para procesar una sección individual (con tareas)
    def process_section(idx: int, start_date: datetime) -> datetime:
        section_title, tasks = sections[idx]
        print(f"\n📌 Sección: {section_title} (inicio: {start_date.strftime('%Y-%m-%d')})")
        cur = start_date
        for task in tasks:
            title = task.get('title')
            if not title:
                continue
            description = task.get('description', 'Sin descripción')
            tags = task.get('tags', [])
            color = task.get('color', 'blue')
            duration = task.get('duration_days', 1.0)

            # Verificar si ya existe
            search = kanboard_rpc("searchTasks", {
                "project_id": project_id,
                "query": f'title:"{title}"'
            })
            if search and len(search) > 0:
                print(f"⏩ Ya existe: {title}")
                cur += timedelta(days=duration)
                continue

            start_str = cur.strftime("%Y-%m-%d")
            due_date = cur + timedelta(days=duration - 1)
            due_str = due_date.strftime("%Y-%m-%d")

            print(f"➕ Creando: {title} ({start_str} → {due_str}) [color={color}, duración={duration}d]")
            task_id = create_task(project_id, title, description, column_id, tags,
                                  start_str, due_str, color)
            if task_id:
                print(f"   ✅ ID {task_id}")
                cur += timedelta(days=duration)
            else:
                print(f"   ❌ Error al crear {title}")
        return cur

    # Procesar grupos paralelos y secuenciales
    i = 0
    while i < len(sections):
        # Determinar si esta sección pertenece a algún grupo
        group = None
        for g in parallel_groups:
            if i in g:
                group = g
                break
        if group is None:
            # Sección individual secuencial
            start = current_date
            end = process_section(i, start)
            section_end_dates[i] = end
            current_date = end
            i += 1
        else:
            # Grupo paralelo: todas las secciones del grupo comienzan en current_date
            group_start = current_date
            group_end_dates = []
            # Procesar cada sección del grupo
            for idx in group:
                if idx >= len(sections):
                    continue
                end = process_section(idx, group_start)
                section_end_dates[idx] = end
                group_end_dates.append(end)
            # La fecha de inicio para lo que sigue después del grupo es el máximo de los fines
            current_date = max(group_end_dates)
            # Saltar todas las secciones del grupo
            i = max(group) + 1

    print("\n✅ Proceso completado.")
    gantt_url = KANBOARD_URL.replace('/jsonrpc.php', '')
    print(f"👉 Ver Gantt: {gantt_url}?controller=TaskGanttController&action=show&project_id={project_id}&plugin=Gantt")

if __name__ == "__main__":
    main()