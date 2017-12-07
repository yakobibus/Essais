// fileEssais.h

# ifndef FILE_ESSAIS_H
# define FILE_ESSAIS_H (1)

namespace file_essais
{
	class EssaisFichier
	{
	public:
		EssaisFichier(std::string fileName = "dummyFile.txt"); //: _fileName ("monBeauFichier.txt") 
		~EssaisFichier();
		EssaisFichier(const EssaisFichier& ef);
		EssaisFichier& operator = (const EssaisFichier& ef);
	private:
		std::string _fileName;
		std::fstream* _fFichier;
		//std::ofstream _ofFichier;
		//std::ifstream _ifFichier;
	};

	class LireFichierTxt
	{
	public :
		LireFichierTxt(std::string fileName);
		~LireFichierTxt();
		LireFichierTxt(const LireFichierTxt& lft) ;
		LireFichierTxt& operator = (const LireFichierTxt& lft) ;
		//
		inline long getFileSize(void) { return _fileSize; }
		void setFileSize(void);
		void readData(void);
		void printFile(void);
	private :
		std::string _fileName;
		std::ifstream* _ifsHandler ;
		long _fileSize;
		std::string _dataString;
	};

	class EcrireFichierTxt
	{
	public :
		EcrireFichierTxt(std::string fileName);
		~EcrireFichierTxt();
		EcrireFichierTxt(const EcrireFichierTxt& eft) ;
		EcrireFichierTxt& operator = (const EcrireFichierTxt& eft) ;
		//
		void readFile(void);
		void writeFile(void);
		void setInFileSize(void);
	private :
		std::string _fileName;
		std::ofstream* _ofsHandle;
		std::ifstream* _ifsHandle;
		std::string _data ;
		std::string _reversedData;
		long _inFileSize ;
	};
}

# endif // FILE_ESSAIS_H
