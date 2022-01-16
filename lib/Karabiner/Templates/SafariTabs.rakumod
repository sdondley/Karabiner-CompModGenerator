use Karabiner::Template;
use Mac::Applications::List;
unit class SafariTabs is Template;

my $tmpl = 'safaritabs.json';

has Str $.tabname;
has Str $.tabnum where *.Numeric;


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



