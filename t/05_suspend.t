#!perl

use strict;
use warnings;
use utf8;

use Vagrant::Wrapper;

use Test::More;

# TODO TODO TODO
my $vagrant = Vagrant::Wrapper->new();
ok $vagrant->can('suspend');

done_testing;
