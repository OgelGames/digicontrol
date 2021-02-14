# Digilines Control [digicontrol]

[![luacheck](https://github.com/OgelGames/digicontrol/workflows/luacheck/badge.svg)](https://github.com/OgelGames/digicontrol/actions)
[![License](https://img.shields.io/badge/License-MIT%20and%20CC%20BY--SA%204.0-green.svg)](LICENSE.md)
[![Minetest](https://img.shields.io/badge/Minetest-5.0+-blue.svg)](https://www.minetest.net)

## Table of Contents

- [Overview](#overview)
- [Nodes](#nodes)
- [Dependencies](#dependencies)
- [Installation](#installation)
- [License](#license)

## Overview

This mod adds nodes to control the flow of digiline messages in various ways, and is designed to be a more streamlined replacement for [`digiline_routing`](https://github.com/numberZero/digiline_routing).

![Overview Screenshot](images/overview.png?raw=true "Overview Screenshot") 

## Nodes

- **Filter** - only lets messages with the correct channel pass through.
- **Limiter** - limits the rate at which messages can pass through.
- **Diode** - only lets messages pass through in one direction.
- **Splitter** - splits messages into two branches, and stops messages going between the branches.
- **Tri-Splitter** - same as Splitter, but splits into three branches.

## Dependencies

**Required**

- `default` (included in [Minetest Game](https://github.com/minetest/minetest_game))
- [`digilines`](https://github.com/minetest-mods/digilines)

**Optional**

- [`basic_materials`](https://gitlab.com/VanessaE/basic_materials)
- `mesecons_materials` (included in [`mesecons`](https://github.com/minetest-mods/mesecons))

## Installation

Download the [master branch](https://github.com/OgelGames/digicontrol/archive/master.zip) or the [latest release](https://github.com/OgelGames/digicontrol/releases), or clone the repository using Git or the [GitHub Desktop](https://desktop.github.com/) app, and follow [the usual installation steps](https://dev.minetest.net/Installing_Mods).

## License

Except for any exceptions stated in [LICENSE.md](LICENSE.md#exceptions), all code is licensed under the [MIT License](LICENSE.md#mit-license), with all textures, models, sounds, and other media licensed under the [CC BY-SA 4.0 License](LICENSE.md#cc-by-sa-40-license). 
