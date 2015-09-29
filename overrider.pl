sub single_override_and_run {
    my($name, $thing, $func) = @_;

    local $$name = $thing;
    return &$func();
}

$foo = 1;

sub foo_plus_one { return $foo + 1; }

print foo_plus_one() . "\n";
print single_override_and_run('foo', 7, \&foo_plus_one);
