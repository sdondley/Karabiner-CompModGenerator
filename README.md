[![Actions Status](https://github.com/sdondley/Karabiner-CompModGenerator/workflows/test/badge.svg)](https://github.com/sdondley/Karabiner-CompModGenerator/actions)

NAME
====

Karabiner::CompModGenerator - Generate complex modifcations for the [Karabiner-Elements](https://karabiner-elements.pqrs.org) app on macOS

SYNOPSIS
========

From the command line:

    kcmg ActivateApps.cfg

DESCRIPTION
===========

This module generates json files containing "complex modification" rules for use with the the [Karabiner-Elements](https://karabiner-elements.pqrs.org) app on macOS. The goal of the module is to make it easier to create and regenerate complex modification files and avoid the headache of editing json files directly.

The files containing the complex modifications are generated from templates, so the rules you can create are limited by the templates provided by the module, which currently include:

  * **ActivateApps** – opens/activiates applications by pressing a modifier key while double or triple tapping another key

  * **SafariTabs** – activate Safari and a specific tab by pressing a modifier key and a double tap (best used in conjunction with Safari's "pinned" tab feature)

More templates will be added in the future. Feel welcome to contribute your own template modules to extend `Karabiner::CompModGenerator`'s capabilities.

Follow the [USAGE](#USAGE) instructions below for more details.

INSTALLATION
============

Assuming Raku and zef is already installed, install the module with:

`zef install Karabiner::CompModGenerator`

Once you get the module installed follow the [USAGE](#USAGE) instructions to learn how to generate new rules for use with Karabiner-Elements.

If you don't have Raku with zef installed yet, it's easiest to install them both with homebrew if you already have brew installed:

`brew install rakudo-star`

If you don't have brew installed, install it with:

`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`

Note, however, that the homebrew install may be months out of date.

To ensure you get the absolute latest version of Raku, [see this page](https://course.raku.org/essentials/how-to-install-rakudo/) for other installation options. Whatever method you choose to install Raku, just be sure the `zef` command gets installed and is working on your machine as well.

USAGE
=====

The four steps to generating and using the complex modification files are:

1. creating a configuration file; see [Configuration File](#Configuration File) for details

2. running the `kcmg` command, followed by the path to your configuration file, to create the json file containing the complex modification rules

3. copy the json file into Karabiner-Elements configuration directory on your drive

4. open Karabiner-Elements and load the new rules

The json file created in step 2 above gets saved to the same directory you ran the command from. It has the same base file name as your configuration file but with a `.json` file extension. Place this file into your Karbiner-Elements configuration directory. By default, this directory is at `~/.config/Karabiner/assets/complex_modifications`.

Now, with the new json file in place, open Karabiner-Elements and do the following:

1. click the "Complex Modifications" tab

2. click the "Add rule" button

3. click "Enable" for all the rules or individual rules you wish to use

Configuration File
------------------

A configuration file is a text file that contains the comma separated values that get inserted into a template file. Each line in the file outputs a new rule that ends up in json file that's output by the `kcmg` command. An associated template module, as determined by the name of the configuration file, contains the logic for processing the configuration file.

You can use any text editor to create the configuration files.

### Naming Your Configuration File

A configuration file can have any file extention. However, the first part of your file name (aka the base name), **must exactly match the name of an installed template module.** For example, if you want your configuration file to use the `Karabiner::Template::ActivateApps` template, name your file something like `ActivateApps.cfg` or `ActivateApps.txt`.

### Writing Your Configuration File

Here is a sample configuration file for use with the `ActivateApps` template:

    # Filename: ActivateApps.cfg
    # lines beginning with the '#' character get ignored

    # LINE FORMAT:
    # 1st app name, 2nd app name*, key, modifier*
    # The '*' indicates an optional field

    Adobe Photoshop 2021, Preview, p, command
    zoom.us, z, option

Blank lines and lines beginning with the '#' sign are are comments and are ignored.

The uncommented lines contain the data that the template inserts into a pre-defined json template file. Each piece of data is delimited with a comma. Spaces before and after a comma are ignored.

The sample configuration file above creates the following three shortcuts:

  * assigns ⌘-p-p (hold down command key and double tap "p") to open Adobe Photoshop

  * assigns ⌘-p-p-p (hold down command key and triple tap "p")to open Preview

  * assigns ⌘-z-z (hold down command key and double tap "z") to open Zoom

Notice the second app name is optional. If only one app name is provided, only one shortcut (a double tap) will be generated. If two app names are provided, the first app is assigned to the double tap shortcut and the second app is assigned to the triple tap shortcut.

The "modifier" argument is also optional. If not provided, it defaults to the "command" key when using the `ActivateApps` template. You may use "option," "control," "shift," or "command" for the modifier key.

**PRO TIP for ActiveApps template:** The app name in the configuration file must exactly match the name of the offical app name as installed on your Mac. The official name can differ substantially than the app's common name. For example, the app name for "Zoom" is "zoom.us". To ensure you app name correct, use the [Mac::Application::List](Mac::Application::List) module installed with this module to list out the apps installed on your machine. Alternatively, use the Karabiner-EventViewer application. The module will warn you if it does not recognize the name of an app in your configuration file.

AUTHOR
======

Steve Dondley <s@dondley.com>

COPYRIGHT AND LICENSE
=====================

Copyright 2022 Steve Dondley

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

