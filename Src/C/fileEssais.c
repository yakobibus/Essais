// fileEssais.c

# include <iostream>
# include <fstream>
//# include <cstdio>
# include <cstring>

# include "fileEssais.h"

namespace file_essais
{
	EssaisFichier::EssaisFichier(std::string fileName) : _fileName(fileName)
	{
		_fFichier = new std::fstream;
		_fFichier->open(_fileName, std::ios::out | std::ios::trunc /*| std::ios::app*/);
		*_fFichier << "Hum, serait-ce embarrassant ?" << std::endl;
		*_fFichier << "- Nous vous recommandons de ne pas descendre de l'arbre avant l'automne" << std::endl;
		*_fFichier << "- Je ne suis pas si certain que ce soit aussi simple, ami" << std::endl;
	}

	//: _fileName ("monBeauFichier.txt") 

	EssaisFichier::~EssaisFichier()
	{
		delete _fFichier;
	}

	EssaisFichier::EssaisFichier(const EssaisFichier & ef)
	{
		if (&ef != this)
		{
			_fileName = ef._fileName;
			delete _fFichier;
			_fFichier = ef._fFichier;
		}
	}

	EssaisFichier & EssaisFichier::operator=(const EssaisFichier & ef)
	{
		if (this != &ef)
		{
			_fileName = ef._fileName;
			delete _fFichier;
			_fFichier = ef._fFichier;
		}
		return *this;
	}

	LireFichierTxt::LireFichierTxt(std::string fileName)
		: _fileName(fileName)
		, _ifsHandler(nullptr)
		, _fileSize(-1)
		, _dataString("")
	{
		_ifsHandler = new std::ifstream;
		_ifsHandler->open(_fileName, std::ios::in | std::ios::binary);
		setFileSize();
		readData();
		printFile();
	}

	LireFichierTxt::~LireFichierTxt()
	{
		_ifsHandler->close();
		delete _ifsHandler;
	}

	LireFichierTxt::LireFichierTxt(const LireFichierTxt & lft)
	{
		if (this != &lft)
		{
			_ifsHandler->close();
			delete _ifsHandler;
			_ifsHandler = lft._ifsHandler;
			_fileName = lft._fileName;
			_fileSize = lft._fileSize;
			_dataString = lft._dataString;
		}
	}

	LireFichierTxt & LireFichierTxt::operator=(const LireFichierTxt& lft)
	{
		if (this != &lft)
		{
			_ifsHandler->close();
			delete _ifsHandler;
			_ifsHandler = lft._ifsHandler;
			_fileName = lft._fileName;
			_fileSize = lft._fileSize;
			_dataString = lft._dataString;
		}
		return *this;
	}

	void LireFichierTxt::setFileSize(void)
	{
		if (_ifsHandler->is_open())
		{
			long currentPosition = _ifsHandler->tellg();
			_ifsHandler->seekg(0, _ifsHandler->end);
			_fileSize = _ifsHandler->tellg();
			_ifsHandler->seekg(currentPosition, _ifsHandler->beg);
		}
		else
		{
			std::cerr << "The file " << _fileName.c_str() << " isn't opened" << std::endl;
		}
	}

	void LireFichierTxt::readData(void)
	{
		if (_fileSize > 0)
		{
			char* zDummy = new char[1 + _fileSize];
			memset(zDummy, 0, _fileSize);
			_ifsHandler->read(zDummy, _fileSize);
			if (_ifsHandler->good())
			{
				_dataString = zDummy;
			}
			else
			{
				std::cerr << "Echec de lecture du fichier " << _fileName.c_str() << std::endl;
			}
			delete[] zDummy;
		}
	}

	void LireFichierTxt::printFile(void)
	{
		std::cout << _dataString.c_str();
	}

	EcrireFichierTxt::EcrireFichierTxt(std::string fileName = "dummyFile.tmp")
		: _fileName(fileName)
		, _ofsHandle(nullptr)
		, _ifsHandle(nullptr)
		, _data("")
		, _reversedData("")
		, _inFileSize(-1)
	{
		_ifsHandle = new std::ifstream(_fileName, std::ios::in);
		_ofsHandle = new std::ofstream("effaceMoi.txt", std::ios::out | std::ios::binary | std::ios::trunc);
		setInFileSize();
		readFile();
		writeFile();
	}

	EcrireFichierTxt::~EcrireFichierTxt()
	{
		_ofsHandle->flush();
		_ofsHandle->close();
		delete _ofsHandle;
		delete _ifsHandle;
	}

	EcrireFichierTxt::EcrireFichierTxt(const EcrireFichierTxt& eft)
	{
		if (this != &eft)
		{
			delete _ofsHandle;
			delete _ifsHandle;
			_ofsHandle = eft._ofsHandle ;
			_ifsHandle = eft._ifsHandle;
			_data = eft._data;
			_reversedData = eft._reversedData;
			_inFileSize = eft._inFileSize;
		}
	}

	EcrireFichierTxt& EcrireFichierTxt::operator=(const EcrireFichierTxt& eft)
	{
		if (this != &eft)
		{
			delete _ofsHandle;
			_ofsHandle = eft._ofsHandle ;
			delete _ifsHandle;
			_ifsHandle = eft._ifsHandle;
			_data = eft._data;
			_reversedData = eft._reversedData;
			_inFileSize = eft._inFileSize;
		}
		return *this;
	}

	void EcrireFichierTxt::readFile(void)
	{
		char* zDummy = new char [1 + _inFileSize];
		memset(zDummy, 0, 1 + _inFileSize);
		_ifsHandle->read(zDummy, _inFileSize);
		_data = zDummy;
		for (int ii = 0; ii < _data.length(); ++ii)
		{
			zDummy[ii] = _data.c_str()[-1 - ii + _data.length()];
		}
		_reversedData = zDummy;
		delete[] zDummy;
	}

	void EcrireFichierTxt::writeFile(void)
	{
		_ofsHandle->write("Hola, amigo\n", 12);
		std::string zozo = "Hum, je ne sais pas ce que vous voulez.\n";
		_ofsHandle->write(zozo.c_str(), zozo.length());
		_ofsHandle->write(_reversedData.c_str(), _reversedData.length());
	}

	void EcrireFichierTxt::setInFileSize(void)
	{
		long currentPosition = _ifsHandle->tellg();
		_ifsHandle->seekg(0, _ifsHandle->end);
		_inFileSize = _ifsHandle->tellg();
		_ifsHandle->seekg(currentPosition, _ifsHandle->beg);
	}

	Personne::Personne(std::string nom, std::string prenom, int age)
		: _nom(nom)
		, _prenom(prenom)
		, _age(age)
	{
	}
	//
	void Personne::affiche(void)
	{
		std::cout << _nom.c_str() << _separateur.c_str() << _prenom.c_str() << _separateur.c_str() << _age << "(" << sizeof(Personne) << ")" << std::endl;
	}
}
