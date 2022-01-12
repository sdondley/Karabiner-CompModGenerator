NAME
====

Karabiner::CompModGenerator - Generate complex modifcations for the [Karabiner-Elements](https://karabiner-elements.pqrs.org) app on macOS

SYNOPSIS
========

From the command line:

```raku
kcmg your_template_file
```

DESCRIPTION
===========

This module generates json files containing complex modifications for use with the the [Karabiner-Elements](https://karabiner-elements.pqrs.org) app on macOS.

The module makes it exceedingly easy to create and update useful complex modifications. The modification files are generated from templates, so the modifications you can generate are limited by those provided by the templates which currently include:

* opening/activiating applications with a modifier key and a double or triple tap of another key

More templates will be added in the future.

There are two steps to generating the complex modification files:

1. set up a configuration file 2. run a command to create the json file containing the modifications

INSTALLATION
============

First, install Raku by following the instructions here:

Now install the module with: `zef install Karabiner::CompModGenerator`

Follow the [USAGE](USAGE) instructions below to learn how to generate files.

USAGE
-----

The first step is create a template file. The format for the template files can be found...

AUTHOR
======

Steve Dondley <s@dondley.com>

COPYRIGHT AND LICENSE
=====================

Copyright 2022 Steve Dondley

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

