use strict;
use Digest::SHA3;

my $TAGS = join('|', qw(Len Msg MD));
my @vecs = ();
while (<DATA>) {
	next unless /^\s*($TAGS)\s*=\s*([\dA-F]+)/o;
	push(@vecs, $2);
}

my $numtests = scalar(@vecs) / 3;
print "1..$numtests\n";

for (1 .. $numtests) {
	my $sha3 = Digest::SHA3->new();		# use SHA3-224 by default
	my $Len = shift @vecs;
	my $Msg = pack("H*", shift @vecs);
	my $MD = shift @vecs;
	my $computed = $sha3->add_bits($Msg, $Len, 1)->hexdigest;
	print "not " unless $computed eq lc($MD);
	print "ok ", $_, "\n";
}

__DATA__
# Keccak(input|01)[r=1152, c=448] truncated to 224 bits, or SHA3-224 as in FIPS 202 draft

Len = 7
Msg = 4C
MD = 255827559076E5ADCBF04537A98CEF483414AE3B81841B528923436E

Len = 1147
Msg = 856344695FFA7F9E71CCA31E66780E83E946374FEB320A3D0D4E944EE8AD38917B892B1E4842817E9B9572EAE8BE6340A1DDED6DDB8216944CD9D403E137F1B3CD53688043E145D6D5BBE9C6A5078958AC10A96F1FB9953983996D386AF3E368394F57A7BABE20A22A7D9F8F5AC665B996B34989CECAFA60A618743CB5970FB4167F6A46635090E32C381D9A8E68DB05
MD = 9C831FF4EC2340AFEE0124D43B7C6F94EA092A08A3C9D610A7C79578

Len = 2037
Msg = B652BCB949215CC82A08AA428F90CAA72755D785F102D112689205ECB97F68844B120FAE0F68F87AFB41BE7AFFE3946CDE47AFDD5F1A2AC8326D1C15976C610CF261F95D49D7F13DF9619D58B585446D0F572514C046AC5DB3AA8CD2BFBA41DC9332ECCD4C9DD946FBC60EA604E9E69319ECA5A3EF3910E446D57AC1543CA4DD29F2A42ED3F12B2F21B40911258DB642365F8D5F9737E3F39D77B8BC53CED9E3A2E0C0C8328F27428764E25CFA14FAA401A42B8C5EC1586DC1B4EA108D8AEC3CCC312738D8320F41917D413D3E5214DC46A7AD5EAB4E7326279CD5CEB30FA881535621E096925D18E62C71CBABEADD9DA58321F80C8F6777FB97C516426A03
MD = 7226B281116D796F7C474195B563AFCD3BB1F4E1B9B7156A03A5E7C9
