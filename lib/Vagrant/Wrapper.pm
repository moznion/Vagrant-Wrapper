package Vagrant::Wrapper;
use 5.008005;
use strict;
use warnings;
use Carp;
use Path::Tiny;

our $VERSION = "0.01";

sub new {
    my ($class) = @_;
    # vagrant command is exist?
    return bless {}, $class;
}

sub up {
    # TODO options
    my ($self, $path) = @_;

    $path ||= Path::Tiny->cwd;
    chdir($path);

    $self->_exec('up');
}

sub _exec {
    my ($self, $cmd, @args) = @_;

    `vagrant $cmd`;
}

1;
__END__

=encoding utf-8

=head1 NAME

Vagrant::Wrapper - It's new $module

=head1 SYNOPSIS

    use Vagrant::Wrapper;

=head1 DESCRIPTION

Vagrant::Wrapper is ...

=head1 LICENSE

Copyright (C) moznion.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

moznion E<lt>moznion@gmail.comE<gt>

=cut
