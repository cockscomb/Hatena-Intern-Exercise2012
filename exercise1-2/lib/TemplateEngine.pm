package TemplateEngine;

use strict;
use warnings;
use utf8;
use FindBin::libs;

use Carp;
use CGI;
use Encode;
use IO::File;

# Set UTF-8 encoding to STDOUT.
binmode(STDOUT, ':utf8');

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

sub format {
  my $self = shift;
  my $placeholder = shift;
  my $format_string = shift;

  # Format when format string was set.
  my $formatted;
  if ($format_string) {
    $formatted = sprintf('%' . $format_string, $placeholder);
  } else {
    $formatted = $placeholder;
  }
  # Escape.
  CGI::escapeHTML($formatted);
}

sub render {
  my $self = shift;
  my %placeholders = %{$_[0]};

  my $rendered = $self->get_template;
  foreach my $key (keys %placeholders) {
    my $placeholder = $placeholders{$key};
    # Replace placeholder with format string.
    $rendered =~ s/{%\s+(?:$key)(?::(?<fmt>[ +-0#]?[0-9.]*[A-Za-z]+))?\s+%}/$self->format($placeholder, $+{fmt})/eg;
  }
  $rendered
}

1;