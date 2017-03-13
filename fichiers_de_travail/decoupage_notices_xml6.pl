#/usr/bin/perl -w
use warnings;
open (IN,"enssib_oai_pmh_perl_collection.xml");

while (<IN>) {
  chomp;
  $ligne=$_;
  if ($ligne =~ /^setName/) {
    $setName=$ligne;
  }
  if ($ligne =~ /^<metadata/) {
    $nomFichier=$ligne;
    $nomFichier=~s/^.*http\:\/\/www\.enssib\.fr\/bibliotheque\-numerique\/documents\///g;
    $nomFichier=~s/\.pdf.*/\.pdf\.txt/g;
    open (OUT,">$nomFichier");
    print OUT $setName,"\n";
    print OUT $ligne;
    close (OUT);
  }
  else {
    next;
  }
}
system ("mv [0-9]*.txt txt_bibliotheque_numerique/metadonnees/");
close (TEMP);
close (IN);
