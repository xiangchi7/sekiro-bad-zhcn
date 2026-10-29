# 只狼 mod「Malevolence」简体中文汉化 · Simplified Chinese Localization

**v1.7 · 2026-10** — 当前版本，与 Releases 里的 zip 是同一份（current version; the zip in Releases is this build）

[中文](#中文) · [English](#english)

---

## 中文

为 *Sekiro: Shadows Die Twice* 的 mod「Malevolence」提供的简体中文语言包。
只替换 `msg\zhocn\` 下两个文本包，不改模型、参数、脚本，可随时删除还原。

### 安装

1. 运行 `install.cmd`（自动定位 Steam 库、备份 `*.bak`；找不到时把 `mods` 文件夹拖上去），
   或手动把 `msg` 复制进 `...\Sekiro\mods\`。`install.cmd /check` 只显示检测路径，不写文件。
2. 标题画面 → `Language` → `Text` → 简体中文 → 重启游戏。

回滚：`restore.cmd`，或删除 `mods\msg\zhocn\` 下这两个文件。

### 已知限制

1. EULA、版权与地区法律声明保留英文。
2. `OK`、`Mild`、若干 `WWW` 占位串保留原样。
3. 英文包另有 8 张表在中文包里缺失或为空，内容为 Dark Souls 3 遗留文本；mod 未改动，
   中文客户端不读取，对显示无影响。
4. 说明文的分段沿用官方简中；约 47 条的中文段落空行比英文少，官方文本本身如此。

### 目录

```
msg/zhocn/item.msgbnd.dcx   道具/招式/敌人等文本（随 Releases 的 zip 发布）
msg/zhocn/menu.msgbnd.dcx   菜单、对白、字幕等文本（随 Releases 的 zip 发布）
install.cmd / restore.cmd
```

### 声明

- 需自备正版游戏与该 mod；本仓库仅含文本资源。
- 游戏文本版权归 FromSoftware / Activision；与 mod 原作者无关，接到要求即撤下。
- 译文为 AI 辅助并统一术语。报错请附表名、条目 id 与截图。

---

## English

Simplified Chinese language pack for the *Sekiro: Shadows Die Twice* mod **"Malevolence"**.
Replaces two text bundles under `msg\zhocn\` only — no models, params or scripts; remove it any time.

### Installation

1. Run `install.cmd` (finds the Steam library, backs up `*.bak`; drag your `mods` folder onto it if needed),
   or copy `msg` into `...\Sekiro\mods\`. `install.cmd /check` only prints the detected path.
2. Title screen → `Language` → `Text` → Simplified Chinese → restart.

Rollback: `restore.cmd`, or delete the two files under `mods\msg\zhocn\`.

### Known limitations

1. EULA, copyright and regional legal notices stay in English.
2. `OK`, `Mild` and a few `WWW` placeholder strings are left as-is.
3. Eight tables present in the English bundle are missing or empty in the Chinese one; they hold
   Dark Souls 3 leftovers, untouched by the mod, never read by the Chinese client — no visual effect.
4. Chinese paragraph breaks follow the official CN text; ~47 entries keep fewer blank lines than the
   English version, exactly as the official localization does.

### Layout

```
msg/zhocn/item.msgbnd.dcx   items, Combat Arts, enemies (shipped in the release zip)
msg/zhocn/menu.msgbnd.dcx   menus, dialogue, subtitles (shipped in the release zip)
install.cmd / restore.cmd
```

### Notes

- Requires your own copy of the game and the mod; this repository contains text resources only.
- Game text is copyright FromSoftware / Activision. Not affiliated with the mod author; removed on request.
- Translations were produced with AI assistance and reviewed for terminology. Report issues with
  table name, entry id and a screenshot.
