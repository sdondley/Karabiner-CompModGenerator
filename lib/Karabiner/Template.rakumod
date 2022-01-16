unit class Template;
use Mac::Applications::List;
use Template::Classic;

has Str $.key where .chars == 1;
has Str $.mod where (* ~~ any [ 'command', 'option', 'shift', 'control' ]) = 'command';

method description_generator($tmpl) {
    use MONKEY-SEE-NO-EVAL;
    my @values;
    my @usage_names;
    for self.^attributes -> $a {
        my $name = $a.name.substr(2);
        my $value = EVAL "self.$name";
        next if !$value;
        push @values, $value;
        push @usage_names, '$' ~ $name;
    }

    my &render-list := template (EVAL qq|:({@usage_names.join(',')})|), %?RESOURCES{$tmpl}.slurp;
    my $out = render-list |@values;

    my $output;
    for $out.list -> $a {
        $output ~= $a;
    }
    return $output.trim-trailing;
}

method get_bot() {
    q:to/BOT/;

  ]
}
BOT
}

