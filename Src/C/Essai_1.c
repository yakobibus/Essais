// Essai_1.c

# include <iostream>
# include <cstring>
# include "Essai_1.h" 

namespace essai_1 {
	Essai::Essai(int argc, char** argv) : _argc(argc) {
		if (_argc > 0) {
			_argv = new char* [_argc];
		}
		for (int i = 0; i < _argc; ++i) {
			int szArgv_i = strlen(argv[i]);
			_argv[i] = new char[1 + szArgv_i];
			memset(_argv[i], 0, 1 + szArgv_i);
			memcpy(_argv[i], argv[i], szArgv_i);
		}
	}
	//
	Essai::~Essai() {
		if (_argc > 0) {
			for (int i = _argc - 1; i >= 0; --i) {
				std::cout << "Terminating <" << _argv[i] << "> (" << i << ") ..." << std::endl;
				delete[] _argv[i];
			}
			delete[] _argv;
			std::cout << "Done" << std::endl;
		}
	}
	//
	Essai::Essai(const Essai& e) {
		if (this != &e) {
			if (_argc > 0) {
				for (int i = _argc - 1; i >= 0; --i) {
					delete[] _argv[i];
				}
				delete[] _argv;
			}
			//
			_argc = e._argc;

			if (_argc > 0) {
				_argv = new char*[_argc];

				for (int i = 0; i < _argc; ++i) {
					int szArgv_i = strlen(e._argv[i]);
					_argv[i] = new char[1 + szArgv_i];
					memset(_argv[i], 0, 1 + szArgv_i);
					memcpy(_argv[i], e._argv[i], szArgv_i);
				}
			}
		}
	}
	//
	Essai& Essai::operator = (const Essai& e) {
		if (this != &e) {
			if (_argc > 0) {
				for (int i = _argc - 1; i >= 0; --i) {
					delete[] _argv[i];
				}
				delete[] _argv;
			}
			//
			_argc = e._argc;

			if (_argc > 0) {
				_argv = new char*[_argc];

				for (int i = 0; i < _argc; ++i) {
					int szArgv_i = strlen(e._argv[i]);
					_argv[i] = new char[1 + szArgv_i];
					memset(_argv[i], 0, 1 + szArgv_i);
					memcpy(_argv[i], e._argv[i], szArgv_i);
				}
			}
		}
		return *this;
	}
}

int main_Essai_1(int argc, char**argv) {
	essai_1::Essai e(argc, argv);
	return 0;
}
