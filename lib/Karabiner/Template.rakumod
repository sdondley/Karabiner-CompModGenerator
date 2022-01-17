unit class Template;
use Template::Classic;

has Str $.key where .chars == 1;
has Str $.mod where (* ~~ any [ 'command', 'option', 'shift', 'control' ]) = 'command';

method rule_generator($tmpl) {
    my (@values, @usage_names);

    my @attribute_data = self.^attributes».name».substr(2).map: { $_, self."$_"() };
    for @attribute_data -> $pair {
        push @usage_names, $pair[0];
        push @values, $pair[1];
    }
    my @params = @usage_names.map: { Parameter.new(:name('$' ~ $_)) };

    my &generate-rule := template Signature.new(:@params,
                                  :returns(Seq)),
                                  %?RESOURCES{$tmpl}.slurp;

    return generate-rule(|@values).eager.join.trim-trailing;
}

method get_bot() {
    q:to/BOT/;

  ]
}
BOT
}

