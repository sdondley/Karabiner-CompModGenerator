use Karabiner::Template;
use Mac::Applications::List;
unit class ActivateApps is Template;

my $tmpl = 'double.json';
my $apps = MacAppList.new.find_apps;
has Str $.app1 where * ~~ $apps.any;
has Str $.app2 where * ~~ $apps.any;

multi method create(|c($app1, $key)) {
    self.create(|c, 'command')
}
multi method create($app1, $key, $mod) {
    if $mod.chars == 1 {
        return self.create($app1, $key, $mod, 'command');
    }
    my $a = self.bless(:$app1, :$key, :$mod);
    $a.rule_generator($tmpl);
}
multi method create($app1, $app2, $key, $mod) {
    $tmpl = 'triple.json';
    my $a = self.bless(:$app1, :$app2, :$key, :$mod);
    $a.rule_generator($tmpl);
}

method get_top() {
    q:to/TOP/;
{"title": "Activating Apps",
  "rules": [
TOP
}

=begin pod

Here is a sample configuration file for use with the C<ActivateApps> template:

=begin code
# lines beginning with the '#' character get ignored
# The '*' indicates an optional field
# 1st app name,2nd app name*,key,modifier*

Adobe Photoshop 2021,Preview,p,command
zoom.us,z,option
=end code

This configuration file:

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

=end pod
