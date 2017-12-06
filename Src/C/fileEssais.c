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
		_fFichier = new std::fstream ;
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
		, _fileSize (-1)
		, _dataString( "" )
	{
		/*
		{
			std::ifstream ifs("hou.c");

			if (ifs.is_open()) 
			{
				std::cout << "Ouvert !" << std::endl;
				// print file:
				char c = ifs.get();
				while (ifs.good()) {
					std::cout << c;
					c = ifs.get();
				}
				//
				ifs.close();
			}
			else {
				// show message:
				std::cout << "Error opening file" << std::endl;
			}
		}
		*/

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
			delete _ifsHandler ;
			_ifsHandler = lft._ifsHandler ;
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
			_ifsHandler->seekg (currentPosition, _ifsHandler->beg) ;
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
		std::cout << _dataString.c_str () ;
	}
}
