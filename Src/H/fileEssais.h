// fileEssais.h

# ifndef FILE_ESSAIS_H
# define FILE_ESSAIS_H (1)

namespace file_essais
{
	class EssaisFichier
	{
	public:
		EssaisFichier(std::string fileName = "dummyFile.txt"); //: _fileName ("monBeauFichier.txt") 
		~EssaisFichier() { delete _fFichier; }
	private:
		std::string _fileName;
		std::fstream* _fFichier;
		//std::ofstream _ofFichier;
		//std::ifstream _ifFichier;
	};
}

# endif // FILE_ESSAIS_H
