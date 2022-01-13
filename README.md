[![Actions Status](https://github.com/sdondley/Karabiner-CompModGenerator/workflows/test/badge.svg)](https://github.com/sdondley/Karabiner-CompModGenerator/actions)

NAME
====

Karabiner::CompModGenerator - Generate complex modifcations for the [Karabiner-Elements](https://karabiner-elements.pqrs.org) app on macOS

SYNOPSIS
========

From the command line:

```raku
kcmg your_config_file.txt
```

DESCRIPTION
===========

This module generates json files containing complex modifications for use with the the [Karabiner-Elements](https://karabiner-elements.pqrs.org) app on macOS.

The module makes it exceedingly easy to create and update useful complex modifications. The modification files are generated from templates, so the modifications you can generate are limited by the templates provided by the module, which currently include:

* opening/activiating applications with a modifier key and a double or triple tap of another key

More templates will be added in the future as well as a way to create plugins for this module for adding additional templates.

Follow the [USAGE](USAGE) instructions below for more details.

USAGE
=====

There are a few easy steps to generating the complex modification files:

    1. write the configuration file
    2. run the C<kcmg> command, followed by the name of your configuration
    file, to create the json file containing the modifications
    3. install the json file into Karabiner-Elements configuration directory
    4. open Karabiner-Elements and load the new rules

The json file created by the command in step 2 above will be saved to the same directory your the command from with the same base file name as your configuration file but with a '.json' file extension. Place this file into your Karbiner-Elements configuration directory. By default, this directory is at `~/.config/Karabiner/assets/complex_modifications`. Now you can open Karabiner-Elements and do the following:

    1. click the "Complex Modifications" tab
    2. click the "Add rule" button
    3. click "Enable" for all the rules or individual rules you wish to use

Writing a configuration file
----------------------------

A configuration is just a simple text file that provides text strings to be inserted into the templates. You cna use any text editor to create the configurations.

Here is a sample configuration file:

    # lines that begin with the '#' character are ignore
    # first app name,second app name (optional),key,modifier (optional)
    Adobe Photoshop 2021,Preview,p,command
    zoom.us,z,option

The first two lines that begin with the '#' sign are are comments and are ignored.

The next two lines create the following three shortcuts:

  * assigns ⌘-p-p (hold down command key and double tap "p") to open Adobe Photoshop

  * assigns ⌘-p-p-p (hold down command key and triple tap "z")to open Preview

  * assigns ⌘-z-z (hold down command key and double tap "z") to open Zoom

Notice the second app name is optional. If only one app name is provided, only one shortcut (double tap) will be generated. If two app names are provided, the first app is assigned to the double tap shortcut and the second app is assigned to the triple tap shortcut.

The "modifier" argument is also optional. It not provided, it defaults to the "command" key.

**IMPORTANT: **Ensure no spaces exists before and after commas.

INSTALLATION
============

If you don't have Raku installed, it's easiest to install with homebrew if you already have brew installed:

`brew install rakudo-star`

If you don't have brew installed, install it with:

`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`

For other options for installing Raku, see [read this page.](https://course.raku.org/essentials/how-to-install-rakudo/). Whatever way you choose, just be sure the `zef` command is installed on your machine as well.

Once Raku is installed, install the module with: `zef install Karabiner::CompModGenerator`

Now follow the [USAGE](USAGE) instructions below to learn how to generate files.

AUTHOR
======

Steve Dondley <s@dondley.com>

COPYRIGHT AND LICENSE
=====================

Copyright 2022 Steve Dondley

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

