#! /usr/bin/perl -w

#! /usr/bin/env perl 

use 5.26.1 ; # implies "use strict;"
use warnings;
use autodie;

# use ./pkg_argument ;

my sub is_option {
    my $ref_arg = shift ;
    return $$ref_arg =~ /^-{1,2}[^-]/ ;
}

my sub trim {
    # arg : the ref of the string to trim
    my $ref_str = shift ;
    $$ref_str =~ s/^ *// ; # ltrim
    $$ref_str =~ s/ *$// ; # rtrim
}

my sub get_args {
    # arg : the reference of the args string
    # ----
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
    # --------
    my $ref_optAttendues = { # Anonymous hash reference
      (
        'version' => 5
      , 'cases'   => 6 
      , 'help'    => 5
      , 'specifs' => 5
      )
    };  # avec arguments | obligatoire [0:aucun arg, 1: 1arg, 5:option accessoire, 7:option obligatoire]
    # ---
    my $ref_argv = shift ;      # 1er : ref \@argv ;
    my $ref_prm_liste = shift ; # 2e  : ref de la liste des parametres à récolter
    my $ref_opt_liste = shift ; # 3e  ! ref du hash des options
    my $nb_opt = 0 ;

    while(my ($arg_position, $arg_valeur) = each @{$ref_argv}) {
        trim(\$arg_valeur) ;

        if (is_option (\$arg_valeur)) {
            $nb_opt++ ;
            #push ( @ {$arg_valeur}, $nb_opt ) ;
            $ref_opt_liste->{key}[ $nb_opt ] = $arg_valeur ;
            say "  $arg_position : <$arg_valeur> est une option" ;
        }
        else {
            push @{ $ref_prm_liste }, $arg_valeur ;
            #say "  $arg_position. ($arg_valeur) est un parametre"  ;
        }
    }
}

my sub print_usage {
    say "\n
    Usage : tp_z_casino [options] [arguments]  \n
    -----   options :  \n
             --help : la commande affiche cette page d'aide et s'arrête  \n
             --specs : la commande affiche les specifications et s'arrête  \n
             --cases <nombre_de_cases> : permet de saisir le nombre de cases souhaitées.  \n
               Par defaut, il y a 19 cases dans la partie \n
               L'option --cases attend obligatoirement en parametre une valeur numérique  \n
             -- : indicateur de fin des options. aucune option n'est plus attendue à sa suite  \n
            arguments :  \n
              aucun  \n
    " ;
}

my sub get_specifications {
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

    return $regle ;
}

sub main {
    # Récupérer les arguments
    my @argv = @ARGV ;
    my @prm_liste ;
    my %opt_liste ;

    get_args (\@argv, \@prm_liste, \%opt_liste) ;
    say "liste des prm [@prm_liste]" ;
    foreach my $str (keys %opt_liste ) {
        print "opt <$str> " ;
    }
}

main (@ARGV) ;
