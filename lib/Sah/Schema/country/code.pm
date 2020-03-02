package Sah::Schema::country::code;

# AUTHORITY
# DATE
# DIST
# VERSION

use Locale::Codes::Country_Codes ();

my $codes = [sort (
    keys(%{ $Locale::Codes::Data{'country'}{'code2id'}{'alpha-2'} }),
    keys(%{ $Locale::Codes::Data{'country'}{'code2id'}{'alpha-3'} }),
)];
die "Can't extract country codes from Locale::Codes::Country_Codes"
    unless @$codes;

our $schema = [str => {
    summary => 'Country code (alpha-2 or alpha-3)',
    description => <<'_',

Accept only current (not retired) codes. Alpha-2 or alpha-3 codes are accepted.

Code will be converted to lowercase.

_
    match => '\A[a-z]{2,3}\z',
    in => $codes,
    'x.perl.coerce_rules' => ['From_str::to_lower'],
    examples => [
        {data=>'', valid=>0},
        {data=>'ID' , valid=>1, res=>'id'},
        {data=>'IDN', valid=>1, res=>'idn'},
        {data=>'xx', valid=>0},
        {data=>'xxx', valid=>0},
    ],
}, {}];

1;
# ABSTRACT:

=head1 SEE ALSO

L<Sah::Schema::country::code::alpha2>

L<Sah::Schema::country::code::alpha3>
