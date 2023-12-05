# pilot-lua-template
> Template for writing programs in pilot.lua

## Features
- Full code completion using [Luau LSP](https://github.com/JohnnyMorganz/luau-lsp) and [autopilot.lua](https://github.com/flxwed/autopilot.lua)
- Compiles code into a single script for microcontrollers using [luabundler](https://github.com/Benjamin-Dobell/luabundler)
- Organized repository setup for development

## Getting Started
Click the "Use this template" button or download this repository wherever you like.

### Remove this text and everything above it.

# my-pilot-lua-project

## Build
Download `luabundler` globally using npm

```
npm install -g luabundler
```

Then, open the repository in VSCode and press `Ctrl + Shift + B` to run the bundler.

The file will be outputted at `build/bundle.lua`.
