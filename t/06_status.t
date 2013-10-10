#!perl

use strict;
use warnings;
use utf8;

use Vagrant::Wrapper;

use Test::More;

# TODO TODO TODO
my $vagrant = Vagrant::Wrapper->new();
ok $vagrant->can('status');

done_testing;
