# Grok Terminal Theme

A matching WezTerm color scheme and Starship prompt built on the Grok palette:
graphite surfaces, warm ivory text, and one desaturated steel accent. This
repository contains the working configurations used to validate both.

## Contents

```
wezterm/wezterm.lua       Full WezTerm configuration and Grok Obsidian scheme
starship/starship.toml    Full Starship powerline preset and Grok palette
```

The WezTerm file includes the author's tab/status formatting and keybindings so
the rendered result is reproducible. The Starship file preserves the original
prompt layout, module order, and Nerd Font symbols; only the palette and the
final prompt character changed.

## WezTerm

### Install

Back up the existing configuration, then copy the file into place.

Windows:

```powershell
Copy-Item $HOME\.config\wezterm\wezterm.lua $HOME\.config\wezterm\wezterm.lua.bak
Copy-Item .\wezterm\wezterm.lua $HOME\.config\wezterm\wezterm.lua
```

Reload WezTerm with `LEADER r` (the default leader is `Ctrl+A`), or restart it.

The configuration requires a Nerd Font; it uses JetBrainsMono Nerd Font with
fallbacks. It also enables WebGPU, Mica on Windows, and 96% window opacity.

The scheme defines:

| Role | Color |
| --- | --- |
| Terminal canvas | `#101010` |
| Tab bar / chrome | `#101010` |
| Active tab | `#131313` |
| Selection | `#262B30` |
| Foreground | `#E6E4DF` |
| Accent / cursor | `#A9BCCB` |
| ANSI black / bright black | `#1A1A1A` / `#3A3A3A` |

The tab bar background deliberately matches the terminal canvas, so there is no
divider band across the top. The tab edge and window-frame bottom border use the
same `#101010`.

Only the `grok` palette table, the `Grok Obsidian` color scheme, and the tab and
status handlers are theme-specific; the rest is a normal WezTerm setup.

## Starship

### Install

```powershell
Copy-Item $HOME\.config\starship.toml $HOME\.config\starship.toml.bak
Copy-Item .\starship\starship.toml $HOME\.config\starship.toml
```

Ensure Starship is initialized in the PowerShell profile:

```powershell
starship init powershell | Invoke-Expression
```

Open a new shell. The prompt now uses the `grok_obsidian` palette, dark tinted
segment backgrounds, a steel OS/user segment with dark text, and a `→` prompt
character on success and error.

| Token | Color |
| --- | --- |
| `color_fg0` (text) | `#E6E4DF` |
| `color_orange` (OS/user) | `#A9BCCB` |
| `color_on_accent` | `#101010` |
| `color_yellow` (directory) | `#2A3036` |
| `color_aqua` (git) | `#22302D` |
| `color_blue` (languages) | `#202A33` |
| `color_bg3` / `color_bg1` | `#1A1A1A` / `#0C0C0C` |
| `color_green` / `color_red` | `#93AF97` / `#C98F87` |

## Verification

- WezTerm configuration validates with `wezterm --config-file ... ls-fonts`.
- Both the WezTerm window and the Starship prompt were rendered with truecolor
  on Windows 11 (x64).
- Tested with WezTerm `20260929-043349-cab25161` and Starship `1.26.0`.

If the prompt appears monochrome, check that `NO_COLOR` is unset and that
PowerShell is using `$PSStyle.OutputRendering = 'Host'`; a `PlainText` renderer
strips the palette before it reaches the terminal.

## License

MIT. Unofficial theme; not affiliated with xAI.
