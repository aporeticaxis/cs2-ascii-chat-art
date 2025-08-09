<h1 align="center">CS2 ASCII Chat Art</h1>
<p align="center">Make MM chat pretty again — generate line-by-line ASCII/Braille Art in Chat.
  <a href="center">
    <img src="https://github.com/user-attachments/assets/f6133ff0-113e-401b-81cb-6486d196ca5b" alt="shrek">
  </a>
</p>

<p align="center">
  <a href="https://github.com/yourname/cs2-ascii-chat-art/releases">
    <img alt="Release" src="https://img.shields.io/github/v/release/yourname/cs2-ascii-chat-art?display_name=tag">
  </a>
  <a href="#">
    <img alt="OS" src="https://img.shields.io/badge/Windows-10%2B-blue">
  </a>
</p>

## TL;DR
A slightly different take on [moio9's cs2-text-art script](https://github.com/moio9/cs2-text-art).
> Allows you to display any saved ASCII/Braille `.txt` art in CS2 chat, **line-by-line**. **`7`/`F7` = next**, **`8`/`F8` = reset**. Works when dead; clean menu; organized folders.

### Quick Setup
- **Where** — `...\Steam\steamapps\common\Counter-Strike Global Offensive\game\csgo\cfg`
- **Generate** — `art.bat <name> <file>.txt`
- **Load** — `+exec autoexec.cfg` (or `exec autoexec` once per session)
- **Use** — Console: `art.menu` / `art.list` → `art_<name>` → `7`/`F7` to step, `8`/`F8` to reset

## Table of Contents
- [TL;DR](#tldr)
- [Directory tree](#directory-tree)
- [What it does](#what-it-does-at-a-glance)
- [Features](#features)
- [Files](#files)
- [Quick Start](#quick-start--5-minutes)
- [Menu sample](#the-menu-sample)
- [Controls](#controls-at-a-glance)
- [Generated outputs](#generated-outputs)
- [Full example input](#full-example-input-txt--braille-art)
- [Pro tips](#pro-tips)
- [Troubleshooting](#troubleshooting)
- [Credits](#credits)

## Directory tree
```text
cfg/
├─ art_cry/
│  ├─ meta.txt
│  ├─ output_1.cfg
│  ├─ …
│  ├─ output_n.cfg
│  └─ select.cfg
├─ art_shrek/
│  └─ …
├─ art_core.cfg
├─ art_select.cfg
├─ art_menu.cfg
├─ autoexec.cfg
└─ art.bat
```
---

## What it does (at a glance)

Converts any multi‑line text block (ASCII/Braille art) art file (`<name>.txt`) into an organized subdir within cfg/ with individual **per‑line `say` configs** that you cycle with keybinds. You control the pacing (it's not automatic - the script auto-cycles the bind associated with the default key, so you just need to press 7 (F7 if dead) to iterate through the whole folder/art piece).

> **Demo album (replace with your links):**
>
> 1. *New folder after generation:* `art_cry/`
> 2. *Inside a set:* `output_1.cfg ... output_10.cfg`, `select.cfg`, `meta.txt`
> 3. *In‑game menu:* `art.menu`

---

## Features

* **Works when you're dead** — mirrored default 7/8 binds on **F7/F8**
* **Clear menu** — `art.menu` shows commands + line counts
* **Quick reset** — `8/F8` primes last used art piece
* **Auto‑organizes** — one folder per art; global menu regenerates

---

## Files

* `art.bat` — generator (creates `art_<name>` folder, outputs, and the menu & select aliases)
* `art_core.cfg` — safe defaults for 7/8/F7/F8 before a set is selected
* `art_select.cfg` — aliases like `art_cry`, `art_shrek`, `art.menu`, `art.list`
* `autoexec.cfg` — loads core + select on startup

---

## Quick Start (≈ 5 minutes)

### 1) Put files in your CS2 config folder

```
C:\Program Files (x86)\Steam\steamapps\common\Counter-Strike Global Offensive\game\csgo\cfg
```

### 2) Open a Command Prompt **in that folder**

* Shift + Right‑click → **Open command window here** (or PowerShell, then type `cmd`)
* Alternatively, open cmd/powershell, type `cd C:\Program Files (x86)\Steam\steamapps\common\Counter-Strike Global Offensive\game\csgo\cfg`

### 3) Generate a set (examples)

```bat
art.bat cry cry.txt
art.bat shrek shrek.txt
```


<details>
<summary><strong>PowerShell</strong></summary>
  
```
  cd "C:\Program Files (x86)\Steam\steamapps\common\Counter-Strike Global Offensive\game\csgo\cfg" .\art.bat cry cry.txt
```

</details>

<details> <summary><strong>CMD</strong></summary>
  
```
cd "C:\Program Files (x86)\Steam\steamapps\common\Counter-Strike Global Offensive\game\csgo\cfg" art.bat cry cry.txt
```

</details>


This creates `art_cry/` and `art_shrek/` subdirs in cfg/ with `output_*.cfg`, `select.cfg`, and `meta.txt`. It also rebuilds the global menu/aliases.

### 4) Ensure aliases load each session

* **Preferred:** add to Steam launch options: `+exec autoexec.cfg`
* **Or manual each launch:** open the console → `exec autoexec`

Create or add to your `autoexec.cfg`:

```cfg
exec art_core
exec art_select
```

### 5) Use it in‑game

### Command Reference
<div align="center">
  <table align="center">
    <thead>
      <tr>
        <th>Command</th>
        <th>Purpose</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>art.menu</code></td>
        <td>Show menu of installed art + line counts</td>
      </tr>
      <tr>
        <td><code>art.list</code></td>
        <td>Quick list of installed art names</td>
      </tr>
      <tr>
        <td><code>art_&lt;name&gt;</code></td>
        <td>Select a specific art set (e.g., <code>art_cry</code>)</td>
      </tr>
      <tr>
        <td><code>exec autoexec</code></td>
        <td>Load aliases if they’re not active</td>
      </tr>
    </tbody>
  </table>
</div>

## The Menu (sample)
<p align="center">
<img src=https://github.com/user-attachments/assets/8d9b83e7-9b10-47a8-a828-d4a1ebd8d507 alt=Menu Screenshot)
</p>

---

## Controls (at a glance)

<div align="center">
  <table align="center">
    <thead>
      <tr>
        <th>Key</th>
        <th>Action</th>
        <th>When</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>7</code></td>
        <td>Next line</td>
        <td>Alive</td>
      </tr>
      <tr>
        <td><code>F7</code></td>
        <td>Next line</td>
        <td>Dead / spectating</td>
      </tr>
      <tr>
        <td><code>8</code></td>
        <td>Reset to start</td>
        <td>Alive</td>
      </tr>
      <tr>
        <td><code>F8</code></td>
        <td>Reset to start</td>
        <td>Dead / spectating</td>
      </tr>
    </tbody>
  </table>
</div>

<p align="center">
<img src=https://github.com/user-attachments/assets/3351f497-cc2e-4ac8-8b07-9961c3f52e79 alt=Loaded Artwork)
</p>

---

### Generated Outputs 
What's in the cfg files that our `art.bat` creates? — let's look at `art_cry/output_*.cfg` (concatenated excerpt)

```cfg
// output_1.cfg
say ⠄⠄⠄⠄⠄⢀⣠⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣄⠄⠄⠄⠄⠄⠄
bind 7 exec art_cry/output_2
bind F7 exec art_cry/output_2
bind 8 exec art_cry/output_1
bind F8 exec art_cry/output_1

// output_2.cfg
say ⠄⠄⠄⢀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣆⠄⠄⠄⠄
bind 7 exec art_cry/output_3
bind F7 exec art_cry/output_3
bind 8 exec art_cry/output_1
bind F8 exec art_cry/output_1

// output_3.cfg
say ⠄⠄⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠄⠄⠄
bind 7 exec art_cry/output_4
bind F7 exec art_cry/output_4
bind 8 exec art_cry/output_1
bind F8 exec art_cry/output_1

// ...

// output_10.cfg (last)
say ⠄⠄⠄⠄⠄⠄⠄⠈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣤⠄⠄⠄⠄⠄⠄⠄⠄
echo [done] (press 8/F8 to reset)
bind 7  "echo [done]"
bind F7 "echo [done]"
bind 8  exec art_cry/output_1
bind F8 exec art_cry/output_1
```

### Global aliases — `art_select.cfg` (rebuilt by the batch)

```cfg
alias art.menu  "exec art_menu"
alias art.list  "echo Available art: cry shrek"
alias art_cry   "exec art_cry/select"
alias art_shrek "exec art_shrek/select"
```

### art_core.cfg

```cfg
// Before selection, 7/8/F7/F8 just nudge you to the menu
bind 7  "echo > No art selected. Type art.menu"
bind F7 "echo > No art selected. Type art.menu"
bind 8  "echo > No art selected. Type art.menu"
bind F8 "echo > No art selected. Type art.menu"

alias art.menu "exec art_menu"
```

---

## Full example input (.txt) — **Braille art**

1) Save **`cry.txt`** (below). 

```
⠄⠄⠄⠄⠄⢀⣠⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣄⠄⠄⠄⠄⠄⠄
⠄⠄⠄⢀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣆⠄⠄⠄⠄
⠄⠄⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠄⠄⠄
⠄⠄⣾⣿⡿⠟⡋⠉⠛⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠛⠉⠉⠙⠻⣿⣿⣇⠄⠄
⠄⢠⣿⡏⢰⣿⣿⡇⠄⠄⢸⣿⣿⣿⠿⠿⣿⣿⣿⠁⣾⣿⣷⠄⠄⠘⣿⣿⠄⠄
⠄⠸⣿⣇⠈⠉⠉⠄⠄⢀⣼⡿⠋⠄⠄⠄⠄⠙⢿⣄⠙⠛⠁⠄⠄⢠⣿⣿⠄⠄
⠄⠄⢿⣿⡇⠄⠄⠄⣶⣿⣿⢁⣤⣤⣤⣤⣤⣤⠄⣿⣷⠄⠄⠄⠈⢹⣿⡟⠄⠄
⠄⠄⠈⢿⡗⠄⠄⢸⣿⣿⣿⣶⣶⣶⣶⣶⣶⣶⣶⣿⣿⠄⠄⠄⠄⢸⡟⠄⠄⠄
⠄⠄⠄⠄⠳⡀⠄⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠄⠄⠄⠄⠌⠄⠄⠄⠄
⠄⠄⠄⠄⠄⠄⠄⠈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣤⠄⠄⠄⠄⠄⠄⠄⠄
```

Generate with `art.bat cry cry.txt` (or whatever you want to save it as)

---

## Pro tips

* **Team chat variant:** change `say` → `say_team` in the generator if you only want teammates to see it.
* **Width:** CS2 truncates long lines; keep art ≤ \~50 visible characters wide.
* **Encoding:** Save your `.txt` as UTF‑8 to avoid garbled characters.
* **Refresh the menu after adding/removing sets:** `exec art_select` then `art.menu` (_or_ if you add the commands to an autoexec key bind [say 9, for ex.] then that also hot-refreshes instead of needing to type `exec art_select` manually.)

---

## Troubleshooting

* **`art.menu` unknown?** → `exec autoexec` (or ensure `+exec autoexec.cfg` in launch options).
* **`'art_name' not recognized?`** → `exec art_select` then `art.menu`.
* **Keys do nothing?** → You haven’t selected a set (`art_<name>`), or another bind overwrote 7/8/F7/F8.
* **Changed files while CS2 is open?** → `exec art_select` to refresh aliases.
* **Skipped a line in your selected art?** → You may have been pressing the step key too fast. Also, if sending multiple inputs at the same time (say while running or playing the game simultaneously), the server can sometimes drop inputs and this can cause the ordering to skip/chop. 

---

## Credits

* Original: [moio9/cs2-text-art](https://github.com/moio9/cs2-text-art)
* This release adds: multi-select menu, spectator binds, reset, and folder structure,

**Download:** *[Github](https://github.com/aporeticaxis/cs2-ascii-chat-art/main/)*

**Heads-up:** Use responsibly. Don’t spam during clutches or to harass players. Servers may drop inputs if you mash keys too fast. :) Share your best art in the comments! 
