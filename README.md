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

This module generates json files containing complex modifications for use with the the [Karabiner-Elements](https://karabiner-elements.pqrs.org) app on macOS. The goal of the module is to make it easier to update and regenerate complex modification files without having to edit json files directly.

The complex modification files are generated from templates, so the modifications you can generate are limited by the templates provided by the module, which currently include:

  * **ActivateApps** – opening/activiating applications with a modifier key while double or triple tapping another key

  * **SafariTabs** – activate Safari and specific tab with a modifier key and a double tap (ideally suited for use with Safari's "pinned" tab feature)

More templates will be added in the future. And feel welcome to contribute your own template modules to extend `Karabiner::CompModGenerator` capabilities.

Follow the [USAGE](#USAGE) instructions below for more details.

USAGE
=====

There are a few easy steps to generating the complex modification files:

1. write the configuration file; see [Configuration File](#Configuration File) for details

2. run the `kcmg` command, followed by the name of your configuration file, to create the json file containing the modifications

3. copy the json file into Karabiner-Elements configuration directory on your drive

4. open Karabiner-Elements and load the new rules

The json file created by the command in step 2 above gets saved to the same directory you ran the command from with the same base file name as your configuration file but with a '.json' file extension. Place this file into your Karbiner-Elements configuration directory. By default, this directory is at `~/.config/Karabiner/assets/complex_modifications`. Now you can open Karabiner-Elements and do the following:

1. click the "Complex Modifications" tab

2. click the "Add rule" button

3. click "Enable" for all the rules or individual rules you wish to use

Configuration File
------------------

A configuration file is a text file that contains the comma separated strings that get inserted into the template files. Each line will insert a new "description" rule in the json file that's generated. 

You can use any text editor to create the configuration files.

### Naming Your Configuration File

Your configuration files can have any file extention. However, the first part of your file name (aka the base name), **must exactly match the name of an installed template module.** For example, if you want you configuration file to use the `Karabiner::Template::ActivateApps` template, name your file something like `ActivateApps.cfg` or `ActivateApps.txt`.

### Writing Your Configuration File

Here is a sample configuration file for use with the `ActivateApps` template:

    # lines beginning with the '#' character get ignored
    # The '*' indicates an optional field
    # 1st app name,2nd app name*,key,modifier*

    Adobe Photoshop 2021,Preview,p,command
    zoom.us,z,option

The first three lines beginning with the '#' sign are are comments and are ignored. The blank line is also skipped.

The next two lines generate the necessary json for the following three shortcuts:

  * assigns ⌘-p-p (hold down command key and double tap "p") to open Adobe Photoshop

  * assigns ⌘-p-p-p (hold down command key and triple tap "p")to open Preview

  * assigns ⌘-z-z (hold down command key and double tap "z") to open Zoom

Notice the second app name is optional. If only one app name is provided, only one shortcut (double tap) will be generated. If two app names are provided, the first app is assigned to the double tap shortcut and the second app is assigned to the triple tap shortcut.

The "modifier" argument is also optional. If not provided, it defaults to the "command" key. You may use "option," "control," "shift," or "command" for the modifier key.

**PRO TIP:** You must type in the exact name of the app. To ensure you get the correct app name, you can use the [Mac::Application::List](Mac::Application::List) module installed with this module to list out the apps installed on your machine. Alternatively, use the Karabiner-EventViewer application.

INSTALLATION
============

If you don't have Raku installed, it's easiest to install with homebrew if you already have brew installed:

`brew install rakudo-star`

If you don't have brew installed, install it with:

`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`

For other options for installing Raku, [read this page.](https://course.raku.org/essentials/how-to-install-rakudo/) Whatever way you choose, just be sure the `zef` command is installed and working on your machine as well.

Once Raku (and zef) is installed, install the module with:

`zef install Karabiner::CompModGenerator`

Now follow the [USAGE](#USAGE) instructions below to learn how to generate files.

AUTHOR
======

Steve Dondley <s@dondley.com>

COPYRIGHT AND LICENSE
=====================

Copyright 2022 Steve Dondley

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

