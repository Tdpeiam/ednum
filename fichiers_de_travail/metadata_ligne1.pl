#!/usr/bin/perl -w

open (fichier, "enssib_oai_pmh_perl.xml");
open (pdf, ">lignes_pdf.txt");

#ligne=<fichier>;

while (<fichier>) {
	chomp;
	@1=split(/\<dc:identifier\>/);
	@2=split(/\<\/dc:identifier\>/,@1[1]);
	$identifier=@2[0];
	next if $identifier =~ /^$/;
	print $identifier,"\n";
	print pdf $identifier;
	my $pdf = qx{wget --quiet $identifier};
}

close (fichier);
close (pdf);
