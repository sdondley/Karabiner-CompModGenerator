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
        self.create($app1, $key, $mod, 'command');
        return;
    }
    my $a = self.bless(:$app1, :$key, :$mod);
    $a.description_generator($tmpl);
}
multi method create($app1, $app2, $key, $mod) {
    $tmpl = 'triple.json';
    my $a = self.bless(:$app1, :$app2, :$key, :$mod);
    $a.description_generator($tmpl);

}

method get_top() {
    q:to/TOP/;
{"title": "Activating Apps",
  "rules": [
TOP
}



