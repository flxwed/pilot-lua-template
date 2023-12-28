# pilot-lua-template
> Template for writing programs in pilot.lua

## Features
- Full code completion using [Luau LSP](https://github.com/JohnnyMorganz/luau-lsp) and [autopilot.lua](https://github.com/flxwed/autopilot.lua)
- Code formatting and linting using [StyLua](https://github.com/JohnnyMorganz/StyLua) and [Selene](https://github.com/Kampfkarren/selene) (Requires extension)
- Compiles into a single, obfuscated script ready for microcontrollers using [darklua](https://github.com/seaofvoices/darklua)

## Getting Started
Click the "Use this template" button or download this repository wherever you like.

### Remove this text and everything above it.

# my-pilot-lua-project

## Build
To build:

1. Install [aftman](https://github.com/LPGhatguy/aftman)
2. Run `aftman install` to install dependencies
2. Build the project with darklua

```bash
darklua process src/init.lua build/bundle.lua
> successfully processed 1 file (in 7.6709ms)
```

The file will be written to `build/bundle.lua`.
