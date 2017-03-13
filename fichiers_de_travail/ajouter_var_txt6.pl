#/usr/bin/perl -w

use warnings;
#use File::Slurp;
#use Unicode::Normalize;
#use Text::StripAccents;


open (P,"lignes_pdf.txt") || die ("Erreur d'ouverture du fichier"); #ouverure du document contenant l'intitulé de tous les mémoires téléchargés

while (<P>) { #tant que je suis dans P
my $ligne=$_; #attribution à la variable $ligne la ligne courante
$ligne=~s/\.pdf/\.pdf\.txt/g; #modification de l'extension des fichiers pour correspondre au nom des txt

  next if $ligne =~/annexes\.pdf\.txt/; #sauter les annexes des mémoires
  next if $ligne =~/-2\.pdf\.txt/; #sauter les annexes des mémoires

  open (TEMP,">temporaire.txt") || die ("Erreur d'ouverture du fichier"); #ouverture d'un fichier temporaire qui stockera temporairement les lignes du mémoire

  open (M,"./txt_bibliotheque_numerique/metadonnees/$ligne") || die ("Erreur d'ouverture du fichier"); #ouverture de chaque fichier contenant les métadonnées des mémoires correspondants

  print TEMP ("****"); #imprimer dans le fichier temporaire **** correspondant au début du mémoire pour Iramuteq

  while (<M>) { #tant que je suis dans M
    chomp;
    my $donnee=$_; #attribution à la variable $donnée la ligne courante

    $donnee =~ tr/A-Z/a-z/; #remplacer les majuscule par des minuscules
    $donnee =~ s/é/e/g; #remplacer é par e
    $donnee =~ s/è/e/g; #idem
    $donnee =~ s/à/a/g; #idem
    $donnee =~ s/â/a/g; #idem
    $donnee =~ s/ê/e/g; #idem
    $donnee =~ s/ù/u/g; #idem
    $donnee =~ s/î/i/g; #idem
    $donnee =~ s/ç/c/g; #idem
#     $donnee =~ tr/àèéêëìíîïñòóôõöùúûüýÿ/aeeeeiiiinooooouuuuyy/;

    if ($donnee =~/^setname/) { #si j'ai une ligne commençant par setName
#      my $sansAccent = NFKD( $donnee );
#      $sansAccent =~ s/\p{NonspacingMark}//g;
#      stripaccents($donnee);
      $donnee=~s/^setname: //g; #remplacer setName par rien
      $donnee =~ tr/a-zA-Z/\_/cs; #remplacer tout ce qui n'est pas des lettres par rien
      ($memoires,$master,@nomMaster)=split(/\_/,$donnee);
      $nomMaster=join("",@nomMaster);
      
      #~ memoires_master_archives_numeriques
      #~ memoires_master_culture_de_l_ecrit_et_de_l_image_
      #~ memoires_master_livre_et_savoir_edition_scientifique_et_bibliotheque_
      #~ memoires_master_politique_des_bibliotheques_et_de_la_documentation_
      #~ memoires_master_publication_numerique_
      #~ memoires_master_sciences_de_l_information_et_des_bibliotheques_
      #~ memoires_master_sibist_sciences_de_l_information_et_des_bibliotheques_et_information_scientifique_et_technique_

      print TEMP (" *",$memoires,"_",$nomMaster); #imprimer l'intitulé du méoire dans TEMP avec toutes les modifications précédentes
    }

    else {
		next;
      #~ my $limiteur_arg1 = '<dc:subject>';
      #~ my $limiteur_arg2 = '</dc:subject>';
      #~ my @matched = ($donnee =~ /$limiteur_arg1(.*?)$limiteur_arg2/g);
      #~ $variables=join ("ZZZZZZZ", @matched);
      #~ $variables =~ tr/a-zA-Z//cs; #remplacer tout ce qui n'est pas des lettres par _
      #~ $variables =~ s/ZZZZZZZ/ \*/g;
      #~ print TEMP (" *",$variables);
    }
  }

  close (M); #je ferme M car je n'en ai plus besoin

  print TEMP "\n"; #le petit saut de ligne qui va bien pour séparer les variables du texte

  open (T,"./txt_bibliotheque_numerique.bak/$ligne") || die ("Erreur d'ouverture du fichier"); #ouverture du mémoire au format txt

  while (<T>) { #tant que je suis dans T
    my $aCopier=$_; #attribution à la variable $aCopier la ligne courante
    #chomp($aCopier);
    next if ($aCopier =~ /\|\s*[mémoire|rapport]/i || /^Droits d’auteur/i || /^[-–]\s*[0-9]{1,3}\s*[-–]/ || /^[0-9]{1,3}$/);
    $aCopier =~ tr/A-Z/a-z/; #remplacer les majuscule par des minuscules
    $aCopier=~s/\’/ /g;
    $aCopier=~s/\'/ /g;
    $aCopier=~s/\;/ /g;


    if ($aCopier=~ /^\s*Bibliographie\n$/i || /^\s*sources$/i || /^annexes?\s+[a1]?$/i) {
      last; #je quitte la boucle lorsque j'arrive à la bibliographie ou sources ou annexe car personne ne peut faire pareil!!!!, c'est la seule solution que j'ai trouvé
    }
    print TEMP ("$aCopier"); #imprimer la ligne $aCopier dans TEMP (donc à la suite des **** et de $donnee)

  }
close (T); #je ferme T car je n'en ai plus besoin

  system ("mv temporaire.txt txt_bibliotheque_numerique/$ligne"); #je renomme le fichier temporaire comme le doc d'origine
  close (TEMP);


} #j'ai fini avec P


close (P);
