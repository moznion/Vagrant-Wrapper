#!perl

use strict;
use warnings;
use utf8;

use Vagrant::Wrapper;

use Test::More;

my $vagrant = Vagrant::Wrapper->new;
my $version = $vagrant->version;

ok $version =~ /Vagrant\s+\d+\.\d+\.\d+/, 'fetch version';

done_testing;
