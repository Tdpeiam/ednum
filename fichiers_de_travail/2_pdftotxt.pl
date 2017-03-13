#!/usr/bin/perl -w

open (PDF,"lignes_pdf.txt");


while (<PDF>) {
  chomp;
  $pdf=$_; #initialisation de la variable pdf
  $pdf=~ s/^http:\/\/www\.enssib\.fr\/bibliotheque-numerique\/documents\///g; #remplacement de la chaîne http... par rien => il ne me reste plus que le nom du pdf
# print $pdf;
  system ("pdftotext $pdf $pdf.txt"); #transformer en txt mes pdf
  system ("mkdir txt_bibliotheque_numerique"); #créer un répertoire txt_bibliotheque_numerique
  system ("mv *.txt txt_bibliotheque_numerique"); #déplacer tous mes txt dans le dossier créé précédemment
}


close (PDF);
