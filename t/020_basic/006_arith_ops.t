#!perl -w
use strict;
use Test::More;

use Text::Xslate::Compiler;

#use Data::Dumper; $Data::Dumper::Indent = 1;

my $tx = Text::Xslate::Compiler->new();

my @data = (
    ['<:= $value10 + 11 :>', 21],
    ['<:= $value10 - 11 :>', -1],

    ['<:= 12 + $value10 :>', 22],
    ['<:= 12 - $value10 :>',  2],

    ['<:= $value10 + $value20 :>', 30],
    ['<:= $value0  + $value20 :>', 20],

    ['<:= 1 + 3 + 5 :>',  9],
    ['<:= 1 + 3 - 5 :>', -1],
    ['<:= 1 - 3 + 5 :>',  3],

    ['<:=(1 - 3) + 5 :>',  3],
    ['<:= 1 - (3 + 5):>', -7],

    ['<:= 9 - (3 + (5 - 7)):>',  8],
    ['<:= (3 + (5 - 7)) + 9:>', 10],

    ['<:= 3 * 2 :>', 6],
    ['<:= 3 / 2 :>', 1.5],
    ['<:= 3 % 2 :>', 1],

    ['<:= 1 + 3 * 2 :>', 7],
    ['<:= 1 + 3 / 2 :>', 2.5],
    ['<:= 1 + 3 % 2 :>', 2],
    ['<:= 9 + 3 * 2 :>', 15],
    ['<:= 9 + 3 / 2 :>', 10.5],
    ['<:= 9 + 3 % 2 :>', 10],

    ['<:= 1 + 3 * 2 + 42 :>', 7   + 42],
    ['<:= 1 + 3 / 2 + 42 :>', 2.5 + 42],
    ['<:= 1 + 3 % 2 + 42 :>', 2   + 42],
    ['<:= 9 + 3 * 2 + 42 :>', 15  + 42],
    ['<:= 9 + 3 / 2 + 42 :>', 10.5+ 42],
    ['<:= 9 + 3 % 2 + 42 :>', 10  + 42],

    ['<:= "foo" ~ "bar" :>',         "foobar" ],
    ['<:= "foo" ~ "bar" ~ "baz" :>', "foobarbaz" ],
);

foreach my $pair(@data) {
    my($in, $out) = @$pair;

    my $x = $tx->compile_str($in);

    my %vars = (
        value0  =>  0,
        value10 => 10,
        value20 => 20,
    );
    is $x->render(\%vars), $out, $in;
}

done_testing;
