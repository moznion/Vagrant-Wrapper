package Vagrant::Wrapper;
use 5.008005;
use strict;
use warnings;
use Path::Tiny;
use Scope::Guard;

our $VERSION = "0.01";

sub new {
    my ($class, $path) = @_;

    # TODO [check] vagrant command is exist?

    return bless {
        path => $path,
    }, $class;
}

sub init {
    my ($self, $args) = @_;

    unless ($args->{box_name}) {
        undef $args->{box_url};
    }

    my $guard = $self->_chdir;
    $self->_exec('init', $args->{box_name}, $args->{box_url});
}

sub destroy {
    my ($self, $args) = @_;

    my $guard = $self->_chdir;
    $self->_exec('destroy', '--force', $args->{vm_name});
}

sub up {
    # TODO options
    my ($self) = @_;

    my $guard = $self->_chdir;
    $self->_exec('up');
}

sub _exec {
    my ($self, $cmd, @args) = @_;

    @args = map {$_ || ''} @args;
    my $args = join(' ', @args);

    `vagrant $cmd $args`;
}

sub _chdir {
    my ($self) = @_;

    my $orig_cwd = Path::Tiny->cwd;
    my $path = $self->{path} || $orig_cwd;

    chdir $path;

    return Scope::Guard->new(sub {
        chdir $orig_cwd;
    });
};
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
