ensure_path('TEXINPUTS', './styles//');
ensure_path('BIBINPUTS', './bib//');
ensure_path('BSTINPUTS', './bib//');

$ENV{'TEXINPUTS'}='./tex//:' . $ENV{'TEXINPUTS'}; 
$ENV{'BSTINPUTS'}='./bib//:' . $ENV{'BSTINPUTS'};