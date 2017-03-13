#/usr/bin/perl -w

open (FICHIER,"collections_themes.xml");
open (NOM,">nom_collections_themes_oai.txt");



while (<FICHIER>) {
  $ligne=$_;
  if ($ligne=~/^\<setSpec\>/) {
    chomp($ligne);
    $ligne=~s/^<setSpec>//g;
    $ligne=~s/<\/setSpec>$//g;
    print NOM $ligne,"\t";
  }
  elsif ($ligne=~/^<setName>/) {
    $ligne=~s/^<setName>//g;
    $ligne=~s/<\/setName>$//g;
    print NOM $ligne;
  }
}


close (FICHIER);
close (NOM);
