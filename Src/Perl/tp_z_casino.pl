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
    my @argv = @ARGV ;
    my $argc = 0 + @argv ;
    my $FlagFinDesOptions = 0 ; # Faux
    my @lesOptions ;
    my @lesArgOptions ;
    my @lesArguments ;
    # --
    while(my ($position, $valeur) = each @ARGV)
    {
        print "Prm ". ++$position ."/$argc => [$valeur] :: " ;
        if (is_option($valeur)) {
            # Depiler l'option
            $valeur =~ s/--// ;
            push @lesOptions , $valeur =~ s/^-*// ;
            my $nbOpt = @lesOptions ;
            print ".......Nb options = $nbOpt ....(@lesOptions)..<hum>..." ;

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
                say "C'est une option " ;
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