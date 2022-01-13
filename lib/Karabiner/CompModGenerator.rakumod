unit module Karabiner::CompModGenerator;
use Template::Classic;
use Mac::Applications::List;

my @modifiers = <command option shift control>;
multi description(
              |c(
                  Str:D $app1!,
                  Str:D $app2!,
                  Str:D $key! where .chars == 1,
                  Str:D $mod where ($mod ~~ any @modifiers) = 'command' )) {
    my \d = \(|c[0..2], c[3] // 'command');
    return get_description('resources/triple.json', |d);
}

multi description(
              |c(
                  Str:D $app1!,
                  Str:D $key! where .chars == 1,
                  Str:D $mod where ($mod ~~ any @modifiers) = 'command' )) {
    my \d = \(|c[0..1], c[2] // 'command');
    return get_description('resources/double.json', |d);
}

sub get_description($template, *@values) {
    my @usage_names;
    for callframe(1).code.signature.params[0].sub_signature.params.list -> $i {
        push @usage_names, $i.sigil ~ $i.usage-name;
    }

    use MONKEY-SEE-NO-EVAL;

    my &render-list := template (EVAL qq|:({@usage_names.join(',')})|), $template.IO.slurp;
    my $out = render-list |@values;

    my $return;
    for $out.list -> $a {
        $return ~= $a;
    }
    return $return
}

sub generate_file(Str:D $config!) is export(:MANDATORY) {
    my @descriptions;
    for $config.IO.slurp.lines -> $l {
        next if $l ~~ /^\s*\#/;
        my @args = $l.split(',');
        die "@args[0] is not an app" if !is_an_app(@args[0]);
        die "@args[1] is not an app" if @args[2] && @args[2].Str.chars == 1 && !is_an_app(@args[1]);
        @descriptions.push(description(|@args).trim-trailing);
    }
    my $out = @descriptions.join(",\n");
    'karabiner.json'.IO.spurt(get_top() ~ $out ~ get_bot());
}

sub is_an_app(Str:D $app) {
    state @apps ||= apps();
    return $app ~~ any @apps;
}

sub get_top() {
    q:to/TOP/;
{"title": "Activating Apps",
  "rules": [
TOP
}

sub get_bot() {
    q:to/BOT/;

  ]
}
BOT
}


=begin pod

=head1 NAME

Karabiner::CompModGenerator - Generate complex modifcations for the L<Karabiner-Elements|https://karabiner-elements.pqrs.org> app on macOS

=head1 SYNOPSIS

From the command line:
=begin code :lang<raku>

kcmg your_config_file.txt

=end code

=head1 DESCRIPTION

This module generates json files containing complex modifications for use with
the the L<Karabiner-Elements|https://karabiner-elements.pqrs.org> app on macOS.

The module makes it exceedingly easy to create and update useful complex
modifications. The modification files are generated from templates, so the
modifications you can generate are limited by the templates provided by the
module, which currently include:

* opening/activiating applications with a modifier key and a double or triple
tap of another key

More templates will be added in the future as well as a way to create plugins
for this module for adding additional templates.

Follow the L<USAGE> instructions below for more details.


=head1 USAGE

There are a few easy steps to generating the complex modification files:

1. write the configuration file
2. run the C<kcmg> command, followed by the name of your configuration file, to
create the json file containing the modifications
3. install the json file into Karabiner-Elements configuration directory
4. open Karabiner-Elements and load the new rules

The json file created by the command in step 2 above will be saved to the same
directory your the command from with the same base file name as your
configuration file but with a '.json' file extension. Place this file into your
Karbiner-Elements configuration directory. By default, this directory is at
C<~/.config/Karabiner/assets/complex_modifications>. Now you can open 
Karabiner-Elements and do the following:

1. click the "Complex Modifications" tab
2. click the "Add rule" button
3. click "Enable" for all the rules or individual rules you wish to use

=head2 Writing a configuration file

A configuration is just a simple text file that provides text strings to be
inserted into the templates. You cna use any text editor to create the
configurations.

Here is a sample configuration file:

=begin code
# lines that begin with the '#' character are ignore
# The '*' indicates an optional field
# 1st app name,2nd app name*,key,modifier*
Adobe Photoshop 2021,Preview,p,command
zoom.us,z,option

=end code

The first two lines that begin with the '#' sign are are comments and are ignored.

The next two lines create the following three shortcuts:

=item assigns ⌘-p-p (hold down command key and double tap "p") to open Adobe Photoshop
=item assigns ⌘-p-p-p (hold down command key and triple tap "z")to open Preview
=item assigns ⌘-z-z (hold down command key and double tap "z") to open Zoom

Notice the second app name is optional. If only one app name is provided, only
one shortcut (double tap) will be generated. If two app names are provided, the
first app is assigned to the double tap shortcut and the second app is assigned
to the triple tap shortcut.

The "modifier" argument is also optional. If not provided, it defaults to the
"command" key. You may use "option," "control," "shift," or "command" for the 
modifier.

B<IMPORTANT:> Ensure no spaces exists before and after the commas.

B<PRO TIP:> You must type in the exact name of the app. To ensure you get the
correct app name, use the Karabiner-EventViewer helper app that was installed
along with the Karabiner-Elements apps.



=head1 INSTALLATION

If you don't have Raku installed, it's easiest to install with homebrew if you already have brew installed:

C<brew install rakudo-star>

If you don't have brew installed, install it with:

C</bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)">

For other options for installing Raku, see L<read this
page.|https://course.raku.org/essentials/how-to-install-rakudo/>. Whatever way you choose,
just be sure the C<zef> command is installed on your machine as well.

Once Raku is installed, install the module with: C<zef install Karabiner::CompModGenerator>

Now follow the L<USAGE> instructions below to learn how to generate files.

=head1 AUTHOR

Steve Dondley <s@dondley.com>

=head1 COPYRIGHT AND LICENSE

Copyright 2022 Steve Dondley

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
