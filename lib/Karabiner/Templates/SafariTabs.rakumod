use Karabiner::Template;
use Mac::Applications::List;
unit class SafariTabs is Template;

my $tmpl = 'safaritabs.json';

has Str $.tabname;
has Str $.tabnum where *.Num > 0;


multi method create(|c($tabname, $tabnum, $key)) {
    self.create(|c, 'option')
}
multi method create($tabname, $tabnum, $key, $mod) {
    my $a = self.bless(:$tabname, :$tabnum, :$key, :$mod);
    $a.description_generator($tmpl);
}

method get_top() {
    q:to/TOP/;
{"title": "Activate Safari Tabs",
  "rules": [
TOP
}

=begin pod

Here is a sample configuration file for use with the C<SafariTabs> template:

=begin code
# Tab name,Tab number,key,modifier*
# * denotes optional fields
# default modifier is "option" key

Raku docs,1,r,control
Twitter,2,t
=end code

=item assigns ^-r-r (hold down control key and double tap "r") to activate
Safari and switch to the first tab
=item assigns ⌥-t-t (hold down option key and double tap "t") to activate
Safari and switch to the second tab

B<PRO TIP:> Use Safari's L<pinnned
tab|https://support.apple.com/guide/safari/pin-frequently-visited-websites-ibrw0495694f/mac>
feature so the tabs are fixed to the left-hand side of your tab list to give
tab numbers consistency between different browser windows.

=end pod

