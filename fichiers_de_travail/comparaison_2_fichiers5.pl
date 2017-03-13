#/usr/bin/perl -w
open (OAI,"enssib_oai_pmh_perl.xml");
open (COLL,">enssib_oai_pmh_perl_collection.xml");


while (<OAI>) {
  $ligne=$_;
  if ($ligne !~ /^setSpec: Collection-/) {
    print COLL $ligne;
  }
  else {
    $collection=$ligne;
    chomp($collection);
    $collection=~s/^setSpec: //g;
    open (NOM,"nom_collections_themes_oai.txt"); #j'ouvre ici sinon il ne parcours qu'une fois le fichier, en gros il ne revient jamais au début du fichier ce qui est un gros problème si l'on veut chercher une chaîne
    while (<NOM>) {
      ($setSpec,$setName)=split(/\t/);
      if ($setSpec eq $collection) {
      print COLL "setName: ",$setName;
      }
      else {
        next;
      }
    }
    close (NOM);
  }
}

close (COLL);
close (OAI);
