#! /usr/bin/env perl

use 5.016; # implies "use strict;"
use warnings;
use autodie;

#use utf8 ;

sub specifications {
    # Objet : donner les règles de l'application
    my $regle = "
    Notre règle du jeu
    ------------------
    Bon, la roulette, c'est très sympathique comme jeu, mais un peu trop compliqué
    pour un premier TP. Alors, on va simplifier les règles et je vous présente tout
    de suite ce que l'on obtient :
    Le joueur mise sur un numéro compris entre 0 et 49 (50 numéros en tout). En
    choisissant son numéro, il y dépose la somme qu'il souhaite miser.
    La roulette est constituée de 50 cases allant naturellement de 0 à 49. Les numéros
    pairs sont de couleur noire, les numéros impairs sont de couleur rouge. Le croupier
    lance la roulette, lâche la bille et quand la roulette s'arrête, relève le numéro
    de la case dans laquelle la bille s'est arrêtée. Dans notre programme, nous ne
    reprendrons pas tous ces détails « matériels » mais ces explications sont aussi à
    l'intention de ceux qui ont eu la chance d'éviter les salles de casino jusqu'ici.
    Le numéro sur lequel s'est arrêtée la bille est, naturellement, le numéro gagnant.
    Si le numéro gagnant est celui sur lequel le joueur a misé (probabilité de 1/50,
    plutôt faible), le croupier lui remet 3 fois la somme misée.
    Sinon, le croupier regarde si le numéro misé par le joueur est de la même couleur
    que le numéro gagnant (s'ils sont tous les deux pairs ou tous les deux impairs). Si
    c'est le cas, le croupier lui remet 50 % de la somme misée. Si ce n'est pas le cas,
    le joueur perd sa mise.
    
    Dans les deux scénarios gagnants vus ci-dessus (le numéro misé et le numéro gagnant
    sont identiques ou ont la même couleur), le croupier remet au joueur la somme
    initialement misée avant d'y ajouter ses gains. Cela veut dire que, dans ces deux
    scénarios, le joueur récupère de l'argent. Il n'y a que dans le troisième cas qu'il
    perd la somme misée. On utilisera pour devise le dollar \$ à la place de l'euro pour
    des raisons d'encodage sous la console Windows.
    " 
    ;

    print $regle ;
}

sub effaceMoi {
    my $nb_cases = 19 ;
    my @roulette = 1 .. $nb_cases ;
    for (my $ii = 0 ; $ii < $nb_cases ; $ii += 1)
    {
        print "[$ii] => [$roulette[$ii]] \n";
    }

    my $roro = 1 .. $nb_cases ;

    print @roulette, "\n" ;
    print "roro = [$roro]\n" ;
}

sub jeu_casino {
    # Pour les règles, se reporter aux spécifications
}

my sub is_option
{
    return $_[0] =~ /^-/ || $_[0] =~ /^--/ ;
}
my sub get_option
{
    return $_[0] =~ /^--/ ? substr($_[0], 2) : substr($_[0], 1) ;
}

my sub Usage {
    say "" ;
    say "Usage : tp_z_casino [options] [arguments]" ;
    say "-----  options :" ;
    say "         --help : la commande affiche cette page d'aide et s'arrête" ;
    say "         --specs : la commande affiche les specifications et s'arrête" ;
    say "         --cases <nombre_de_cases> : permet de saisir le nombre de cases souhaitées." ;
    say "           Par defaut, il y a 19 cases dans la partie" ;
    say "           L'option --cases attend obligatoirement en parametre une valeur numérique" ;
    say "         -- : indicateur de fin des options. aucune option n'est plus attendue à sa suite" ;
    say "       arguments :" ;
    say "          aucun" ;
    say "" ;
}

my sub getArgs
    # Pour chaque argument de la liste : 
    # Faire
    #    Si l'argument est une option
    #        Si le FlagFinDesOptions est levé
    #            Afficher l'Usage
    #            Retourner ErreurAppel
    #        Sinon
    #           Dépiler l'argument dans la liste des options
    #           Si l'option attend un parametre
    #              Depiler l'argument suivant dans la liste des optionsArguments à la même position
    #              Si cet argument d'option est une option
    #                 Afficher lUsage
    #                 Retourner ErreurAppel
    #              FinSi
    #           FinSi
    #        FinSi
    #    Sinon
    #        Dépiler l'argument dans la liste des parametres
    #    FinSi
    # FinFaire
{
    my sub nw_depiler_option {
        # reçoit les references de
        # 1. l'option courante
        # 2. la liste des options sans les tirets
        my $ref_optCourante = shift ;
        my $ref_optList = shift ;
        $$ref_optCourante =~ s/^-{1,2}// ;
        push @$ref_optList, ${$ref_optCourante} ;
    }

    my sub depiler_options {
        my $optCourante = shift @_ ; # le premier prm
        my @optLst = @_ ;
        $optCourante =~ s/^-{1,2}// ;
        push @optLst , $optCourante ;

        return $optCourante, @optLst ;
    }

    my sub exists_option {
        # reçoit
        # 1. la reference de l'option recherchée
        # 2. la reference du hachage des options
        # Retourne 0 (False) ou >0 (True)
        # 
        my $optRef = shift ;
        my $optAttenduesRef = shift ; ## %{ $_ } ;
        my @cles = keys %{ $optAttenduesRef } ;
        # say "Gotcha ........$$optRef...(keys %{ $optAttenduesRef }).@cles..............";
        return exists $$optAttenduesRef{$$optRef}  && defined $$optAttenduesRef{$$optRef} ;
    }

    my $ref_optAttendues = { # Anonymous hash reference
      (
        'version' => 5
      , 'cases'   => 6 
      , 'help'    => 5
      , 'specifs' => 5
      )
    };  # avec arguments | obligatoire [0:aucun arg, 1: 1arg, 5:option accessoire, 7:option obligatoire]

    #my %optionsAttendues = (
    #    'version'  => 5
    #  , 'cases' => 6 
    #  , 'help'  => 5
    #  , 'specifs' => 5
    #) ; # avec arguments | obligatoire [0:aucun arg, 1: 1arg, 5:option accessoire, 7:option obligatoire]
    #say "<<<%optionsAttendues>>>" ;

    while (my ($opt, $val) = each %{ $ref_optAttendues } ) {
        print "++++ $opt " ;
        say ' : option accessoire sans argument' if ($val == 0 || $val == 5) ;
        say ' : option accessoire avec un argument' if ($val == 6) ;
        say ' : option obligatoire sans argument' if ($val == 7) ;
        say ' : option obligatoire avec un argument' if ($val == 8) ;
    }
    my $haha = 'version';
    #say "!!! $haha existe et vaut $optionsAttendues{$haha}" if exists $optionsAttendues{$haha};
    # voir if exists et if defined donc if exists && defined :: if exists $optionsAttendues{version}
    #say "<<$optionsAttendues{cases}>>" ;

    # ----
    my @argv = @ARGV ;
    my $argc = 0 + @argv ;
    my $FlagFinDesOptions = 0 ; # Faux
    my @lesOptions ; 
    # my $ref_lesOptions = \@lesOptions ;
    my @lesArgOptions ;
    my @lesArguments ;
    # --
    while(my ($position, $valeur) = each @ARGV)
    {
        print "Prm ". ++$position ."/$argc => [$valeur] :: " ;
        if (is_option($valeur)) {
            # Depiler l'option

            # print "valeur=<$valeur>..." ;
            # $valeur =~ s/^-{1,2}// ;
            # say "...valeur=<$valeur>" ;
            # push @lesOptions , $valeur ; # =~ s/^-{1,2}// ;
            # my $nbOpt = @lesOptions ;
            # print ".......Nb options = $nbOpt ....(@lesOptions)..<hum>..." ;

            if ( $valeur =~ s/^--$// )
            {
                if ($FlagFinDesOptions) {
                    say "EXEPTION : flag jà levé !" ;
                    Usage ();
                }
                else {
                    ++$FlagFinDesOptions ;
                    say "FlagFinDesOptions levé " ;
                }
            }
            else
            {
                my $lastOpt ; #### ici
                my $ref_lastOpt = \$valeur ;
                ($lastOpt, @lesOptions) = depiler_options($valeur, @lesOptions) ;
                #nw_depiler_option ($$ref_lastOpt, @$ref_lesOptions) ;
                print " the last : <<$lastOpt>>" ;
                #my $ref_lastOpt = \$lastOpt ;
                # my $ref_optAttendues = \%optionsAttendues ;
                if ( exists_option($ref_lastOpt, $ref_optAttendues) )
                {
                    while (my ($opt, $val) = each %{ $ref_optAttendues } ) {
                        if ($lastOpt eq $opt) ###  && ( $val == 6 || $val == 8 )
                        {
                            say "!!!!!!!!!!!Argssss!!!!!!!! On MATCH entre $lastOpt et $opt !!! " ;
                            next if 1 == 1;
                            #last if 1 ; ## on cherche un break du while :
                        
                            # Recuperer l'argument de l'option
                            #my $optArg = shift @ARGV ;
                            #unshift @ARGV;
                            #say "Hum !! embarrassant " if $optArg =~ /toto/ ;
                            #my $zip = $optArg =~ /^-{1, 2}/ ;
                            #if $zip 
                            #{
                                #say "EXCEPTION : arg <$optArg> incohérent avec l'option $lastOpt" ;
                            #}
                        }
                        print "++++ $opt " ;
                        say ' : option accessoire sans argument' if ($val == 0 || $val == 5) ;
                        say ' : option accessoire avec un argument' if ($val == 6) ;
                        say ' : option obligatoire sans argument' if ($val == 7) ;
                        say ' : option obligatoire avec un argument' if ($val == 8) ;
                    }
                    
                }
                else 
                {
                    my $pitre = pop @lesOptions ;
                    say "EXCEPTION : option inattendue : $pitre" ;
                }
                say "C'est une option <@lesOptions> " ;
            }
        }
        else {
            say "Simple parametre" ;
        }
    }
}

my sub depotoir
{

    my @argv = @ARGV ;
    my $argc = @argv ;
    my %argList = (
        version => 0
      , _nbCases => 19
      , help    => ''
    );
    
    while (my ($prm, $val) = each %argList) {
        my $zeze = $prm =~ s/^_// ;
        print "$prm => <$val> ".$zeze." \n";
    }
    print "Il y a $argc argument(s) : \n";

    for(my $ii = 0 ; $ii < $argc ; $ii += 1) {
        print " $ii. - $argv[$ii] \n" ;
        
        if ( is_option ( $argv[$ii] ) )
        {
            my $popo = get_option ($argv[$ii]) ;
            print "L'option est [".$popo."]\n" ;
            print " ... et 1 option, 1 : <".get_option ($argv[$ii]).">\n";
        }
    }
}
#
#use experimental 'signatures' ;
#
#sub voir ($v2, $v1, @v3)
#    # Appel : voir ("Bibnette", "Bison fut fut", ('à la une', 'à la deux', 'à la trois'));
#{
#    print "Je vois [$v1], [@v3] et [$v2]\n";
#}

sub main {
    # specifications ;
    getArgs() ;
    jeu_casino ();
}

main (@ARGV) ;
#