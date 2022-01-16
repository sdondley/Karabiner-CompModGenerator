unit module Karabiner::CompModGenerator;

sub generate_output(Str:D $config!) is export(:MANDATORY) {
    if !$config.IO.f {
        die "file $config does not exist";
    }
    my $tmpl = basename $config;
    my $tmpl_module = "Karabiner::Templates::$tmpl";
    require ::($tmpl_module);

    my @descriptions;
    for $config.IO.slurp.lines>>.trim -> $l  {
        next if $l ~~ /^\#/ || !$l;
        my @args = $l.split(',').map: *.trim;
        @descriptions.push(::($tmpl).create(|@args));
    }
    my $out = @descriptions.join(",\n");
    return ::($tmpl).get_top ~ $out ~ ::($tmpl).get_bot;
}

sub basename (Str:D $file) is export(:MANDATORY) {
    return $file.IO.extension('').basename;
}

=begin pod

=head1 NAME

Karabiner::CompModGenerator - Generate complex modifcations for the L<Karabiner-Elements|https://karabiner-elements.pqrs.org> app on macOS

=head1 SYNOPSIS

From the command line:
=begin code

kcmg ActivateApps.cfg

=end code

=head1 DESCRIPTION

This module generates json files containing complex modifications for use with
the the L<Karabiner-Elements|https://karabiner-elements.pqrs.org> app on macOS.
The goal of the module is to make it easier to update and regenerate complex
modification files without having to edit json files directly.

The complex modification files are generated from templates, so the
modifications you can generate are limited by the templates provided by the
module, which currently include:

=item B<ActivateApps> – opening/activiating applications with a modifier key while
double or triple tapping another key
=item B<SafariTabs> – activate Safari and specific tab with a modifier key and a
double tap (ideally suited for use with Safari's "pinned" tab feature)

More templates will be added in the future. And feel welcome to contribute your own
template modules to extend C<Karabiner::CompModGenerator> capabilities.

Follow the L<USAGE|#USAGE> instructions below for more details.

=head1 USAGE

There are a few easy steps to generating the complex modification files:

1. write the configuration file; see L<Configuration File|#Configuration File>
for details

2. run the C<kcmg> command, followed by the name of your configuration file, to
create the json file containing the modifications

3. copy the json file into Karabiner-Elements configuration directory on your
drive

4. open Karabiner-Elements and load the new rules

The json file created by the command in step 2 above gets saved to the same
directory you ran the command from with the same base file name as your
configuration file but with a '.json' file extension. Place this file into your
Karbiner-Elements configuration directory. By default, this directory is at
C<~/.config/Karabiner/assets/complex_modifications>. Now you can open
Karabiner-Elements and do the following:

1. click the "Complex Modifications" tab

2. click the "Add rule" button

3. click "Enable" for all the rules or individual rules you wish to use

=head2 Configuration File

A configuration file is a text file that contains the comma separated strings
that get inserted into the template files. Each line will insert a new
"description" rule in the json file that's generated. 

You can use any text editor to create the configuration files.

=head3 Naming Your Configuration File

Your configuration files can have any file extention. However, the first part
of your file name (aka the base name), B<must exactly match the name of an
installed template module.> For example, if you want you configuration file to
use the C<Karabiner::Template::ActivateApps> template, name your file something
like C<ActivateApps.cfg> or C<ActivateApps.txt>.

=head3 Writing Your Configuration File

Here is a sample configuration file for use with the C<ActivateApps> template:

=begin code
# lines beginning with the '#' character get ignored
# The '*' indicates an optional field
# 1st app name,2nd app name*,key,modifier*

Adobe Photoshop 2021,Preview,p,command
zoom.us,z,option
=end code

The first three lines beginning with the '#' sign are are comments and are
ignored. The blank line is also skipped.

The next two lines generate the necessary json for the following three
shortcuts:

=item assigns ⌘-p-p (hold down command key and double tap "p") to open Adobe Photoshop
=item assigns ⌘-p-p-p (hold down command key and triple tap "p")to open Preview
=item assigns ⌘-z-z (hold down command key and double tap "z") to open Zoom

Notice the second app name is optional. If only one app name is provided, only
one shortcut (double tap) will be generated. If two app names are provided, the
first app is assigned to the double tap shortcut and the second app is assigned
to the triple tap shortcut.

The "modifier" argument is also optional. If not provided, it defaults to the
"command" key. You may use "option," "control," "shift," or "command" for the 
modifier key.

B<PRO TIP:> You must type in the exact name of the app. To ensure you get the
correct app name, you can use the L<Mac::Application::List> module installed
with this module to list out the apps installed on your machine. Alternatively,
use the Karabiner-EventViewer application.

=head1 INSTALLATION

If you don't have Raku installed, it's easiest to install with homebrew if you
already have brew installed:

C<brew install rakudo-star>

If you don't have brew installed, install it with:

C</bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)">

For other options for installing Raku, L<read this
page.|https://course.raku.org/essentials/how-to-install-rakudo/> Whatever way
you choose, just be sure the C<zef> command is installed and working on your
machine as well.

Once Raku (and zef) is installed, install the module with:

C<zef install Karabiner::CompModGenerator>

Now follow the L<USAGE|#USAGE> instructions below to learn how to generate files.

=head1 AUTHOR

Steve Dondley <s@dondley.com>

=head1 COPYRIGHT AND LICENSE

Copyright 2022 Steve Dondley

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
