// Essai_1.h
/// # pragma once


# ifndef ESSAI_1_H
# define ESSAI_1_H (1)

namespace essai_1 {
	class Essai {
	public:
		Essai(int argc, char** argv);
		~Essai();
		Essai(const Essai& e);
		Essai& operator = (const Essai& e);
	private:
		int _argc;
		char** _argv;
	};
}


# endif // ESSAI_1_H
