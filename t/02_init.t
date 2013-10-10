#!perl

use strict;
use warnings;
use utf8;
use Path::Tiny;
use File::Spec::Functions qw/catfile/;

use Vagrant::Wrapper;

use Test::More;

subtest 'no args' => sub {
    my $temp    = Path::Tiny->tempdir;
    my $vagrant = Vagrant::Wrapper->new($temp);

    $vagrant->init;

    ok -f catfile($temp, 'Vagrantfile');
};

subtest 'box name specified' => sub {
    my $temp    = Path::Tiny->tempdir;
    my $vagrant = Vagrant::Wrapper->new($temp);

    $vagrant->init({
        box_name => 'foo',
    });

    my $vagrant_file_path = catfile($temp, 'Vagrantfile');
    my $content           = path($vagrant_file_path)->slurp_utf8;

    ok $content =~ /config\.vm\.box = "foo"/;
};

subtest 'box name and URL specified' => sub {
    my $temp    = Path::Tiny->tempdir;
    my $vagrant = Vagrant::Wrapper->new($temp);

    $vagrant->init({
        box_name => 'foo',
        box_url  => 'http://vagrant.example.com',
    });

    my $vagrant_file_path = catfile($temp, 'Vagrantfile');
    my $content           = path($vagrant_file_path)->slurp_utf8;

    ok $content =~ /config\.vm\.box = "foo"/;
    ok $content =~ m!config\.vm\.box_url = "http://vagrant\.example\.com"!;
};

done_testing;
