# Digilines Control [digicontrol]

[![luacheck](https://github.com/OgelGames/digicontrol/workflows/luacheck/badge.svg)](https://github.com/OgelGames/digicontrol/actions)
[![License](https://img.shields.io/badge/License-MIT%20and%20CC%20BY--SA%204.0-green.svg)](LICENSE.md)
[![Minetest](https://img.shields.io/badge/Minetest-5.0+-blue.svg)](https://www.minetest.net)
[![ContentDB](https://content.minetest.net/packages/OgelGames/digicontrol/shields/downloads/)](https://content.minetest.net/packages/OgelGames/digicontrol/)

## Table of Contents

- [Overview](#overview)
- [Nodes](#nodes)
- [Usage](#usage)
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

## Usage

Digicontrol nodes are designed to be as simple to use as possible. The Diode, Splitter, and Tri-Splitter are similar to mesecons logic gates; they work without any setup.

The Filter can be right-clicked to set the channel it will filter. If left blank it will allow all messages to pass through, if a channel is specified, it will only let messages on that channel through, blocking all others.

![Filter Formspec](images/filter_formspec.png?raw=true "Filter Formspec")

The Limiter can also be right-clicked to set the rate at which messages can pass through. A value of 1 or higher will allow that number of messages to pass through per second, blocking further messages. A value of 0 blocks all messages, and a value of -1 allows an infinite number of messages.

![Limiter Formspec](images/limiter_formspec.png?raw=true "Limiter Formspec")

## Dependencies

**Required**

- `default` (included in [Minetest Game](https://github.com/minetest/minetest_game))
- [`digilines`](https://github.com/minetest-mods/digilines)

**Optional**

- [`basic_materials`](https://gitlab.com/VanessaE/basic_materials)
- `mesecons_materials` (included in [`mesecons`](https://github.com/minetest-mods/mesecons))

## Installation

Download the [master branch](https://github.com/OgelGames/digicontrol/archive/master.zip) or the [latest release](https://github.com/OgelGames/digicontrol/releases), and follow [the usual installation steps](https://wiki.minetest.net/Installing_Mods).

Alternatively, you can download and install the mod from [ContentDB](https://content.minetest.net/packages/OgelGames/digicontrol) or the online content tab in Minetest.

## License

Except for any exceptions stated in [LICENSE.md](LICENSE.md#exceptions), all code is licensed under the [MIT License](LICENSE.md#mit-license), with all textures, models, sounds, and other media licensed under the [CC BY-SA 4.0 License](LICENSE.md#cc-by-sa-40-license). 
