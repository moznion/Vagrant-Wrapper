#!perl

use strict;
use warnings;
use utf8;
use Path::Tiny;

use Vagrant::Wrapper;

use Test::More;


my $original_exec = *Vagrant::Wrapper::_exec{CODE};
undef *Vagrant::Wrapper::_exec;
*Vagrant::Wrapper::_exec = sub {
    my ($self, $cmd, @args) = @_;
    return "vagrant $cmd", Path::Tiny->cwd;
};

my $vagrant = Vagrant::Wrapper->new();

subtest 'no path' => sub {
    my ($cmd, $path) = $vagrant->up;
    is $cmd,  'vagrant up', 'command is right';
    is $path, Path::Tiny->cwd;
};

subtest 'path specified' => sub {
    my $expected_path = Path::Tiny->cwd . '/t';
    my (undef, $path) = $vagrant->up($expected_path);
    is $path, $expected_path;
};

undef *Vagrant::Wrapper::_exec;
*Vagrant::Wrapper::_exec = $original_exec;

done_testing;
