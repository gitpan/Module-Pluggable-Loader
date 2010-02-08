package Module::Pluggable::Loader;
use 5.008;
use strict;
use warnings;
our $VERSION = '0.01';

sub import {
    my ($class, @namespaces) = @_;
    my $caller = (caller)[0];
    require Module::Pluggable;
    Module::Pluggable->import(
        package     => $caller,
        search_path => \@namespaces,
        (   @Devel::SearchINC::inc
            ? (search_dirs => \@Devel::SearchINC::inc)
            : ()
        ),
        require => 1
    );
    $caller->plugins;  # just load the plugins
}
1;
__END__

=head1 NAME

Module::Pluggable::Loader - just load plugins, aware of development directories

=head1 SYNOPSIS

    use Module::Pluggable::Loader 'My::Plugin::Namespace';

=head1 DESCRIPTION

This module is a simple loader for plugins found by L<Module::Pluggable>. The
search paths can be specified when using the module. L<Module::Pluggable>'s
C<search_dirs> option will be made aware of development directories found by
L<Devel::SearchINC>, if any exist.

The plugins will then be loaded, but not instantiated.

One use for this module is when defining test classes - see L<Test::Class> -
as plugins. You don't want to instantiate those classes, just load them and
let L<Test::Class> handle the rest.

=head1 FUNCTIONS

=over 4

=item C<import>

Handles the calls to L<Module::Pluggable> at compile-time, that is, when
calling C<use()> on this module.

=back

=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests through the web interface at
L<http://rt.cpan.org>.

=head1 INSTALLATION

See perlmodinstall for information and options on installing Perl modules.

=head1 AVAILABILITY

The latest version of this module is available from the Comprehensive Perl
Archive Network (CPAN). Visit L<http://www.perl.com/CPAN/> to find a CPAN
site near you. Or see L<http://search.cpan.org/dist/Module-Pluggable-Loader/>.

The development version lives at L<http://github.com/hanekomu/module-pluggable-loader/>.
Instead of sending patches, please fork this project using the standard git
and github infrastructure.

=head1 AUTHORS

Marcel GrE<uuml>nauer, C<< <marcel@cpan.org> >>

=head1 COPYRIGHT AND LICENSE

Copyright 2010 by Marcel GrE<uuml>nauer

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
