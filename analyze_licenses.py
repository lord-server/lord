#!/usr/bin/env python3

# Одноразовый на коленке, поэтому ИИ.

"""
Скрипт для поиска и анализа файлов лицензий в директории mods.
Создаёт CSV с информацией о лицензиях для каждого мода.
"""

import os
import re
import csv
import argparse
import fnmatch
from pathlib import Path

MODS_DIR = Path("./mods")
OUTPUT_FILE = Path("./mods-licenses.csv")
EXCLUDE_FILE = Path("./.distribution-exclude")

LICENSE_EXTENSIONS = {'.md', '.txt', ''}
LICENSE_NAMES = {'license', 'licence', 'copyright', 'readme'}

OUR_PATTERNS = [
    re.compile(r'alek13', re.IGNORECASE),
    re.compile(r'alek\b', re.IGNORECASE),
    re.compile(r'lord\s*team', re.IGNORECASE),
    re.compile(r'чибрикин', re.IGNORECASE),
    re.compile(r'александр', re.IGNORECASE),
]

LICENSE_PATTERNS = {
    'MIT': re.compile(r'\bMIT\b', re.IGNORECASE),
    'GPL': re.compile(r'\bGPL(?:-?v?(\d+(?:\.\d+)?)?\+?)?\b', re.IGNORECASE),
    'LGPL': re.compile(r'\bLGPL(?:-?v?(\d+(?:\.\d+)?)?\+?)?\b', re.IGNORECASE),
    'Apache': re.compile(r'\bApache(?:\s*License)?(?:\s*v?(\d+\.?\d*))?\b', re.IGNORECASE),
    'BSD': re.compile(r'\bBSD\b', re.IGNORECASE),
    'CC0': re.compile(r'\bCC0\b', re.IGNORECASE),
    'CC BY': re.compile(r'\bCC[\s\-]*BY(?:[\s\-]?(?:NC|ND|SA|\d+\.?\d*))*\b', re.IGNORECASE),
    'CC BY-SA': re.compile(r'\bCC[\s\-]*BY[\s\-]*SA(?:[\s\-]?\d+\.?\d*)?\b', re.IGNORECASE),
    'CC BY-NC': re.compile(r'\bCC[\s\-]*BY[\s\-]*NC(?:[\s\-]?(?:SA|ND|\d+\.?\d*))?\b', re.IGNORECASE),
    'Public Domain': re.compile(r'\bpublic\s*domain\b', re.IGNORECASE),
    'WTFPL': re.compile(r'\bWTFPL\b|do what the fuck you want', re.IGNORECASE),
    'DWYWPL': re.compile(r'\bDWYWPL\b', re.IGNORECASE),
    'ISC': re.compile(r'\bISC\b', re.IGNORECASE),
    'Zlib': re.compile(r'\bZlib\b', re.IGNORECASE),
    'AGPL': re.compile(r'\bAGPL\b', re.IGNORECASE),
    'All Rights Reserved': re.compile(r'\ball\s*rights\s*reserved\b', re.IGNORECASE),
}

COMMERCIAL_ALLOWED = {'MIT', 'GPL', 'LGPL', 'Apache', 'BSD', 'CC0', 'CC BY', 'CC BY-SA', 
                      'Public Domain', 'WTFPL', 'DWYWPL', 'ISC', 'Zlib', 'AGPL', 'AGPL 3'}
COMMERCIAL_FORBIDDEN = {'CC BY-NC', 'All Rights Reserved'}

COPYLEFT_LICENSES = {'GPL', 'LGPL', 'AGPL', 'CC BY-SA'}


def load_excluded_patterns():
    """Загружает паттерны исключений из файла .distribution-exclude."""
    if not EXCLUDE_FILE.exists():
        return []
    
    patterns = []
    try:
        with open(EXCLUDE_FILE, 'r', encoding='utf-8') as f:
            for line in f:
                line = line.strip()
                if line and not line.startswith('#') and line.startswith('/mods/'):
                    patterns.append(line)
    except Exception as e:
        print(f"Ошибка чтения файла исключений: {e}")
        return []
    
    return patterns


def is_excluded(mod_path, patterns):
    """Проверяет, попадает ли мод под один из паттернов исключения."""
    for pattern in patterns:
        # Убираем начальный / если есть для корректного сравнения
        pattern_clean = pattern.lstrip('/')
        mod_path_clean = mod_path.lstrip('/')
        
        # Прямое совпадение (case-insensitive)
        if fnmatch.fnmatch(mod_path_clean.lower(), pattern_clean.lower()):
            return True
        
        # Если паттерн заканчивается на /*, проверяем подкаталоги
        if pattern_clean.endswith('/*'):
            pattern_base = pattern_clean[:-2]
            # Проверяем, начинается ли путь мода на базовый путь паттерна
            if mod_path_clean.lower().startswith(pattern_base.lower() + '/'):
                return True
            # Или совпадает напрямую
            if fnmatch.fnmatch(mod_path_clean.lower(), pattern_base.lower()):
                return True
    
    return False


def get_mods_list():
    """Получает список модов из команды voxrame each-mod print."""
    import subprocess
    try:
        result = subprocess.run(['./voxrame', 'each-mod', 'print'], 
                              capture_output=True, text=True, check=True)
        mods = [line.strip() for line in result.stdout.strip().split('\n') if line.strip()]
        return mods
    except subprocess.CalledProcessError as e:
        print(f"Ошибка выполнения команды voxrame: {e}")
        return []
    except FileNotFoundError:
        print("Файл voxrame не найден")
        return []


def is_our_mod(content):
    """Проверяет, является ли мод "нашим" (содержит alek/alek13 или Lord Team)."""
    for pattern in OUR_PATTERNS:
        if pattern.search(content):
            return True
    return False


def extract_licenses(content):
    """Извлекает все типы лицензий из текста."""
    licenses_found = set()
    content_lower = content.lower()
    
    if 'freesound.org' in content_lower or 'attribution' in content_lower:
        if 'creative commons 0' in content_lower or 'cc0' in content_lower or 'license: cc0' in content_lower:
            licenses_found.add('CC0')
        if re.search(r'attribution\s+\d+\.?\d*', content_lower):
            licenses_found.add('CC BY')
    
    if 'permission is hereby granted' in content_lower:
        has_other_license = any(x in content_lower for x in ['gnu', 'gpl license', 'lgpl license', 'apache license', 'bsd license'])
        has_mit_header = 'mit license' in content_lower or 'the mit' in content_lower
        if not has_other_license or has_mit_header:
            licenses_found.add('MIT')
    
    for license_name, pattern in LICENSE_PATTERNS.items():
        match = pattern.search(content)
        if match:
            if match.groups() and match.group(1):
                licenses_found.add(f"{license_name} {match.group(1)}")
            else:
                licenses_found.add(license_name)
    
    return list(licenses_found)


def categorize_licenses(content, all_licenses):
    """Разделяет лицензии на код и изображения/текстуры."""
    code_licenses = []
    img_licenses = []
    
    content_lower = content.lower()
    
    code_section_patterns = [
        r'(?:source\s*code|code|software|lua|program)(?:[\s\-]*license)?[:\s\n]+([^\n]*?(?:\b(?:MIT|GPL|LGPL|Apache|BSD|CC0|WTFPL|ISC|Zlib)\b)[^\n]*)',
        r'(?:license\s*of\s*source\s*code)[:\s\n]+([^\n]*?(?:\b(?:MIT|GPL|LGPL|Apache|BSD|CC0|WTFPL|ISC|Zlib)\b)[^\n]*)',
    ]
    
    media_section_patterns = [
        r'(?:media|textures?|models?|sounds?|images?|graphics?)(?:[\s\-]*license)?[:\s\n]+([^\n]*?(?:\b(?:CC|MIT|GPL|LGPL|Apache|BSD|public\s*domain|WTFPL|ISC|Zlib)\b)[^\n]*)',
        r'(?:license[s\s]*of\s*media)[:\s\n]+([^\n]*?(?:\b(?:CC|MIT|GPL|LGPL|Apache|BSD|public\s*domain|WTFPL|ISC|Zlib)\b)[^\n]*)',
    ]
    
    for pattern in code_section_patterns:
        matches = re.findall(pattern, content_lower, re.IGNORECASE | re.DOTALL)
        for match in matches:
            for lic in all_licenses:
                if lic.lower() in match.lower():
                    code_licenses.append(lic)
    
    for pattern in media_section_patterns:
        matches = re.findall(pattern, content_lower, re.IGNORECASE | re.DOTALL)
        for match in matches:
            for lic in all_licenses:
                if lic.lower() in match.lower():
                    img_licenses.append(lic)
    
    if not code_licenses and not img_licenses:
        if len(all_licenses) == 1:
            code_licenses = all_licenses
        elif 'MIT' in all_licenses:
            code_licenses = [lic for lic in all_licenses if 'MIT' in lic]
            img_licenses = [lic for lic in all_licenses if 'MIT' not in lic]
        elif any('CC' in lic for lic in all_licenses):
            code_licenses = [lic for lic in all_licenses if 'CC' not in lic and 'Public' not in lic]
            img_licenses = [lic for lic in all_licenses if 'CC' in lic or 'Public' in lic]
        else:
            code_licenses = all_licenses
    
    code_licenses = list(dict.fromkeys(code_licenses))
    img_licenses = list(dict.fromkeys(img_licenses))
    
    return code_licenses, img_licenses


def determine_main_license(code_licenses, all_licenses):
    """Определяет основную лицензию мода."""
    if code_licenses:
        return code_licenses[0]
    elif all_licenses:
        return all_licenses[0]
    return 'Unknown'


def is_commercial_use_allowed(all_licenses):
    """Определяет, разрешено ли коммерческое использование."""
    if not all_licenses:
        return 'no'  # Если нет информации - считаем что нет
    
    for lic in all_licenses:
        lic_base = lic.split()[0]  # Берём основное название без версии
        if lic_base in COMMERCIAL_FORBIDDEN:
            return 'no'
    
    # Если есть хотя бы одна разрешающая лицензия - считаем что можно
    for lic in all_licenses:
        lic_base = lic.split()[0]
        if lic_base in COMMERCIAL_ALLOWED:
            return 'yes'
    
    return 'no'


def is_copyleft(all_licenses):
    """Определяет, является ли лицензия copyleft."""
    if not all_licenses:
        return 'no'
    
    for lic in all_licenses:
        lic_base = lic.split()[0]
        if lic_base in COPYLEFT_LICENSES:
            return 'yes'
    
    return 'no'


def find_license_files_for_mod(mod_path):
    """Ищет все файлы лицензий в директории мода."""
    mod_dir = Path(mod_path)
    license_files = []
    
    for filename in os.listdir(mod_dir):
        name_lower = filename.lower()
        base_name = name_lower
        ext = ''
        
        if '.' in name_lower:
            parts = name_lower.rsplit('.', 1)
            base_name = parts[0]
            ext = '.' + parts[1]
        
        if base_name in LICENSE_NAMES and ext in LICENSE_EXTENSIONS:
            license_files.append(mod_dir / filename)
    
    return license_files


def analyze_mod(mod_path):
    """Анализирует мод и возвращает информацию о лицензии."""
    # Проверка для модов из _minetest_game
    if mod_path.startswith('mods/_minetest_game/'):
        return {
            'path': mod_path,
            'our?': 'no',
            'license': 'LGPL 2.1',
            'code-license': 'LGPL 2.1',
            'media-licenses': ['CC BY-SA 3.0'],
            'all-licenses': ['LGPL 2.1', 'CC BY-SA 3.0'],
            'commercial-use': 'yes',
            'copyleft': 'yes',
        }
    
    # Проверка для модов из WorldEdit
    if mod_path.startswith('mods/_various/WorldEdit/'):
        return {
            'path': mod_path,
            'our?': 'no',
            'license': 'AGPL 3',
            'code-license': 'AGPL 3',
            'media-licenses': ['CC BY-SA 4.0', 'CC BY 4.0'],
            'all-licenses': ['AGPL 3', 'CC BY-SA 4.0', 'CC BY 4.0'],
            'commercial-use': 'yes',
            'copyleft': 'yes',
        }
    
    license_files = find_license_files_for_mod(mod_path)
    
    if not license_files:
        # Лицензия не найдена
        return {
            'path': mod_path,
            'our?': '?',
            'license': '',
            'code-license': '',
            'media-licenses': [],
            'all-licenses': [],
            'commercial-use': 'no',
            'copyleft': 'no',
        }
    
    # Читаем все файлы лицензий и объединяем информацию
    all_content = ''
    for license_path in license_files:
        try:
            with open(license_path, 'r', encoding='utf-8', errors='ignore') as f:
                content = f.read()
                all_content += '\n\n---\n' + content
        except Exception as e:
            print(f"Ошибка чтения {license_path}: {e}")
            return {
                'path': mod_path,
                'our?': '?',
                'license': '',
                'code-license': '',
                'media-licenses': [],
                'all-licenses': [],
                'commercial-use': 'no',
                'copyleft': 'no',
            }
    
    our_mod = 'yes' if is_our_mod(all_content) else 'no'
    all_licenses = list(dict.fromkeys(extract_licenses(all_content)))
    code_licenses, img_licenses = categorize_licenses(all_content, all_licenses)
    main_license = determine_main_license(code_licenses, all_licenses)
    commercial_use = is_commercial_use_allowed(all_licenses)
    copyleft = is_copyleft(all_licenses)
    
    return {
        'path': mod_path,
        'our?': our_mod,
        'license': main_license,
        'code-license': code_licenses[0] if code_licenses else '',
        'media-licenses': img_licenses,
        'all-licenses': all_licenses,
        'commercial-use': commercial_use,
        'copyleft': copyleft,
    }


def main():
    parser = argparse.ArgumentParser(description='Анализ лицензий модов')
    parser.add_argument('--skip-excluded', action='store_true', 
                       help='Пропускать моды, указанные в .distribution-exclude')
    args = parser.parse_args()
    
    print("Получение списка модов...")
    mods_list = get_mods_list()
    print(f"Найдено {len(mods_list)} модов")
    
    excluded_patterns = []
    if args.skip_excluded:
        excluded_patterns = load_excluded_patterns()
    
    unknown_count = 0
    skipped_count = 0
    results = []
    all_licenses = {}
    for mod_path in sorted(mods_list):
        if args.skip_excluded and is_excluded(mod_path, excluded_patterns):
            skipped_count += 1
            continue
        
        info = analyze_mod(mod_path)
        results.append(info)
        if info['our?'] == '?':
            unknown_count += 1
            print(info)
        
        # Собираем все лицензии с подсчётом количества модов
        for lic in info['all-licenses']:
            if lic in all_licenses:
                all_licenses[lic] += 1
            else:
                all_licenses[lic] = 1
    
    with open(OUTPUT_FILE, 'w', newline='', encoding='utf-8') as f:
        writer = csv.writer(f)
        writer.writerow(['path', 'our?', 'license', 'code-license', 'media-licenses', 'all-licenses', 'commercial-use', 'copyleft'])
        
        for info in results:
            writer.writerow([
                info['path'],
                info['our?'],
                info['license'],
                info['code-license'],
                str(info['media-licenses']),
                str(info['all-licenses']),
                info['commercial-use'],
                info['copyleft'],
            ])
    
    print(f"\nРезультаты сохранены в {OUTPUT_FILE}")
    print(f"Всего проанализировано модов: {len(results)}")
    if args.skip_excluded:
        print(f"Пропущено модов (по исключениям): {skipped_count}")
    print(f"Неизвестных модов: {unknown_count}")
    
    if all_licenses:
        print(f"\nВсе найденные лицензии ({len(all_licenses)}):")
        for lic, count in sorted(all_licenses.items(), key=lambda x: (-x[1], x[0])):
            print(f"  - {lic:<20}: {count} мод(а/ов)")


if __name__ == '__main__':
    main()
