# Path of Building - Agent Context

## Project Overview

**Path of Building (PoB)** is an offline build planner for **Path of Exile** - a complex ARPG build planning tool with:
- Passive skill tree planner
- Offence/defence calculations
- Skill and item planners
- Build sharing via share codes
- Automatic updating system

### Testing
```bash
# Run tests via Docker
docker-compose up

# Run specific test
docker-compose run --rm busted-tests busted --lua=luajit /workdir/path/to/spec.lua
```

## Coding Standards & Conventions

### Lua Style
- **Indent:** 4 tabs
- **Naming:** `PascalCase` for classes/functions, `lowercase` for variables
- **Comments:** Single-line `--`, no inline comments unless necessary
- **Type Hints:** EmmyLua style `---@param`, `---@return`

## Key Files Summary

| File | Purpose | Size/Notes |
|------|---------|------------|
| `src/Modules/ModParser.lua` | Mod parsing logic | ~4000 lines, complex patterns |
| `src/Data/ModCache.lua` | Cached mod results | Auto-generated, huge |
| `src/Modules/Build.lua` | Build management | ~1700 lines, core functionality |
| `src/Modules/Calcs.lua` | Calculation orchestration | ~900 lines |
| `src/Modules/CalcOffence.lua` | Damage calculations | ~3500 lines |
| `src/Classes/Control.lua` | UI control base | ~250 lines |
| `src/Common.lua` | Utilities, class system | ~450 lines |
| `src/Export/Scripts/mods.lua` | Export mod logic | Used during GGPK export |
