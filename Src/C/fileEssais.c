// fileEssais.c

# include <iostream>
# include <fstream>

# include "fileEssais.h"

namespace file_essais
{
	EssaisFichier::EssaisFichier(std::string fileName) : _fileName(fileName) 
	{
		_fFichier = new std::fstream ;
		_fFichier->open(_fileName, std::ios::out | std::ios::trunc /*| std::ios::app*/);
		*_fFichier << "Hum, serait-ce embarrassant ?" << std::endl;
		*_fFichier << "- Nous vous recommandons de ne pas descendre de l'arbre avant l'automne" << std::endl;
		*_fFichier << "- Je ne suis pas si certain que ce soit aussi simple, ami" << std::endl;
	}
}
