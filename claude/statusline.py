#!/usr/bin/env python3
"""
Claude Code Statusline — 2-line display

Line 1: Model #turns | dirname | branch +added ~modified -deleted △ins▽del
Line 2: ctx ██░░░░░░░░ 10% | 5h ▊░░░░░░░░░ 8% ↺20:23 | 7d 26%
"""
import json, sys, os, subprocess, time
from datetime import datetime, timezone, timedelta

if sys.platform == 'win32':
    sys.stdout.reconfigure(encoding='utf-8')

data = json.load(sys.stdin)

# ── ANSI ──────────────────────────────────────────────────────────────────────
R    = '\033[0m'
DIM  = '\033[2m'
CYAN = '\033[36m'
GRN  = '\033[32m'
RED  = '\033[31m'

BLOCKS         = ' ▏▎▍▌▋▊▉█'
JST            = timezone(timedelta(hours=9))
GIT_CACHE_TTL  = 5   # seconds
GIT_CACHE_PATH = '/tmp/cc-statusline-git-py.json'
SEP            = f' {DIM}|{R} '

# ── Helpers ───────────────────────────────────────────────────────────────────

def gradient(pct):
    # 全体的に暗め・低彩度。85%超のみ控えめな赤みに
    if pct >= 85:
        return '\033[38;2;160;80;70m'
    if pct < 50:
        r = int(80  + pct * 0.6)   # 80→110
        g = int(100 + pct * 0.5)   # 100→125
        b = int(90  - pct * 0.6)   # 90→60
    else:
        t = (pct - 50) / 50
        r = int(110 + t * 50)      # 110→160
        g = int(125 - t * 55)      # 125→70
        b = int(60  - t * 20)      # 60→40
    return f'\033[38;2;{r};{max(g, 0)};{b}m'

def fmt_bar(label, pct):
    pct    = min(max(pct, 0), 100)
    filled = pct * 10 / 100
    full   = int(filled)
    frac   = int((filled - full) * 8)
    b = '█' * full
    if full < 10:
        b += (BLOCKS[frac] if frac > 0 else '') + '░' * (10 - full - (1 if frac > 0 else 0))
    return f'{DIM}{label}{R} {gradient(pct)}{b} {round(pct)}%{R}'

def fmt_reset(s):
    if not s:
        return ''
    try:
        dt = datetime.fromisoformat(s.replace('Z', '+00:00'))
        return dt.astimezone(JST).strftime('%H:%M')
    except Exception:
        return ''


# ── Git (file-cached) ─────────────────────────────────────────────────────────

def git_fresh():
    try:
        return (time.time() - os.path.getmtime(GIT_CACHE_PATH)) < GIT_CACHE_TTL
    except FileNotFoundError:
        return False

def build_git_info(cwd):
    try:
        subprocess.run(['git', '-C', cwd, 'rev-parse', '--git-dir'],
                       check=True, capture_output=True)
    except subprocess.CalledProcessError:
        with open(GIT_CACHE_PATH, 'w') as f:
            json.dump({}, f)
        return

    branch = ''
    try:
        branch = subprocess.check_output(
            ['git', '-C', cwd, '--no-optional-locks', 'branch', '--show-current'],
            stderr=subprocess.DEVNULL).decode().strip()
    except Exception:
        pass

    added = modified = deleted = ins = dels = 0
    try:
        for line in subprocess.check_output(
                ['git', '-C', cwd, '--no-optional-locks', 'status', '--porcelain'],
                stderr=subprocess.DEVNULL).decode().splitlines():
            if len(line) < 2:
                continue
            xy = line[:2]
            if xy == '??' or xy[0] == 'A': added    += 1
            if 'M' in xy:                  modified += 1
            if 'D' in xy:                  deleted  += 1
    except Exception:
        pass

    try:
        for line in subprocess.check_output(
                ['git', '-C', cwd, '--no-optional-locks', 'diff', 'HEAD', '--numstat'],
                stderr=subprocess.DEVNULL).decode().splitlines():
            parts = line.split('\t')
            if len(parts) >= 2 and parts[0] != '-':
                try:
                    ins  += int(parts[0])
                    dels += int(parts[1])
                except ValueError:
                    pass
    except Exception:
        pass

    with open(GIT_CACHE_PATH, 'w') as f:
        json.dump({'branch': branch, 'added': added, 'modified': modified,
                   'deleted': deleted, 'ins': ins, 'del': dels}, f)

def get_git_line(cwd):
    if not git_fresh():
        build_git_info(cwd)
    try:
        with open(GIT_CACHE_PATH) as f:
            gs = json.load(f)
    except Exception:
        return ''

    branch = gs.get('branch', '')
    if not branch:
        return ''

    parts = [f'{GRN}{branch}{R}']
    if gs.get('added',    0): parts.append(f'+{gs["added"]}')
    if gs.get('modified', 0): parts.append(f'~{gs["modified"]}')
    if gs.get('deleted',  0): parts.append(f'-{gs["deleted"]}')
    if gs.get('ins', 0) or gs.get('del', 0):
        parts.append(f'{DIM}△{gs["ins"]}▽{gs["del"]}{R}')
    return ' '.join(parts)

# ── Parse JSON ────────────────────────────────────────────────────────────────

model      = data.get('model', {}).get('display_name', 'Claude')
cwd        = data.get('workspace', {}).get('current_dir', os.getcwd())
ctx_pct    = data.get('context_window', {}).get('used_percentage', 0) or 0
five_data  = data.get('rate_limits', {}).get('five_hour', {})
five       = five_data.get('used_percentage')
week_data  = data.get('rate_limits', {}).get('seven_day', {})
week       = week_data.get('used_percentage')

# ── Line 1: Model #turns | dirname | git ─────────────────────────────────────

dirname  = os.path.basename(cwd.rstrip('/')) or cwd
git_line = get_git_line(cwd)

l1 = [f'{CYAN}{model}{R}', dirname]
if git_line:
    l1.append(git_line)

# ── Line 2: ctx | 5h ↺ | 7d% ─────────────────────────────────────────────────

l2 = []

l2.append(fmt_bar('ctx', ctx_pct))

if five is not None:
    reset_part = f' {DIM}↺{fmt_reset(five_data.get("reset_at"))}{R}' if five_data.get('reset_at') else ''
    l2.append(fmt_bar('5h', five) + reset_part)
else:
    l2.append(f'{DIM}5h --{R}')

if week is not None:
    l2.append(f'{DIM}7d{R} {gradient(week)}{round(week)}%{R}')
else:
    l2.append(f'{DIM}7d --{R}')

# ── Output ────────────────────────────────────────────────────────────────────

print(SEP.join(l1))
print(SEP.join(l2), end='')