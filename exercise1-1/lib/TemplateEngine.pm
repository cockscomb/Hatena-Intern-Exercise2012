package TemplateEngine;

use strict;
use warnings;
use utf8;
use FindBin::libs;

use Carp;
use CGI;
use Encode;
use IO::File;

sub new {
  my $class = shift;
  my %options = @_;

  my $template_path = $options{file};

  $class = ref $class if ref $class;

  my $self = bless {
    template => undef,
    }, $class;

  # Set template path.
  $self->set_template_path($template_path);

  $self;
}

sub get_template {
  my $self = shift;
  # Return template.
  $self->{template};
}

sub set_template_path {
  my $self = shift;
  my $template_path = shift;

  # Open template file.
  my $template_file = IO::File->new($template_path, '<:encoding(utf-8)');
  croak "ERROR: Can't open file $template_path." unless (defined $template_file);
  # Read all lines from template file.
  my @template = $template_file->getlines;
  # Close template file.
  $template_file->close;

  # Set template as joined lines.
  $self->{template} = join '', @template;
}

sub render {
  my $self = shift;
  my %placeholders = %{$_[0]};

  my $rendered = $self->get_template;
  foreach my $key (keys %placeholders) {
    # Escape HTML.
    my $placeholder = CGI::escapeHTML($placeholders{$key});
    # Replace placeholder.
    $rendered =~ s/{%\s+(?:$key)\s+%}/$placeholder/g;
  }
  $rendered
}

1;