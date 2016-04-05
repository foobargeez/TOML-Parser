use strict;
use warnings;
use utf8;

use Test::More tests => 2;
use t::Util;
use Storable 2.38 qw/thaw/;
use MIME::Base64;

use TOML::Parser;

my $toml = do { local $/; <DATA> };

my $expected = thaw(decode_base64(<<'__EXPECTED__'));
BQoZAAAAAAQXBGRkZGQCAAAABGRkZGQKAzIuNQIAAAAEYmJiYgiBAgAAAARhYWFhFBERSlNPTjo6
UFA6OkJvb2xlYW4IgQIAAAAEY2NjYw==

__EXPECTED__

for my $strict_mode (0, 1) {
    my $parser = TOML::Parser->new(strict_mode => $strict_mode);
    my $data   = $parser->parse($toml);
    note explain { data => $data, expected => $expected } if $ENV{AUTHOR_TESTING};
    cmp_fuzzy_deeply $data => $expected, "t/toml/empty_comment.toml: strict_mode: $strict_mode";
}

__DATA__
#
#
# fooo

#

aaaa =   1 #
bbbb  =  2.5#
cccc   = true# cccc

#

#

#aaaa

dddd="dddd"
