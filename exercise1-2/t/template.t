use strict;
use warnings;

use Test::More;
use FindBin::libs;

use_ok 'TemplateEngine';

# Elementaly test.
my $template = TemplateEngine->new( file => 'templates/main.html' );
isa_ok $template, 'TemplateEngine';

my $expected = <<'HTML';
<html>
  <head>
    <title>タイトル</title>
  </head>
  <body>
    <p>これはコンテンツです。&amp;&lt;&gt;&quot;</p>
  </body>
</html>
HTML

cmp_ok $template->render({
    title   => 'タイトル',
    content => 'これはコンテンツです。&<>"',
}), 'eq', $expected;

# Formatting test.
$template = TemplateEngine->new( file => 'templates/format.html' );
isa_ok $template, 'TemplateEngine';

$expected = <<'FORMAT_HTML';
<html>
  <head>
    <title>フォーマット</title>
  </head>
  <body>
    <p>2012/08/10</p>
  </body>
</html>
FORMAT_HTML

cmp_ok $template->render({
    title => 'フォーマット',
    year  => 2012,
    month => 8,
    day   => 10,
}), 'eq', $expected;

done_testing();
