// Essais.c

# include <iostream>
# include <string>
//# include <cstdio>
# include <cstring>

# include "Essais.h"
# include "Smart_Ptr.h"
# include "fileEssais.h"

// shared_ptr

// unique_ptr

std::string f_string(char* s)
{
	if (s == nullptr)
	{
		return std::string{};
	}
	else
	{
		return std::string{s};
	}
}

void essais(void)
{
	/* 
	// 1.ici.
	sort(a, b, [](T x, T y) { return x.rank() < y.rank() && x.value() < y.value(); });

	auto lessT = [](T x, T y) { return x.rank() < y.rank() && x.value() < y.value(); };

	sort(a, b, lessT);
	find_if(a, b, lessT);
	// 1.ici. 
	*/
}


// Template functions :
template <typename T>
inline const T& Max(const T& t, const T& u)
{
	return t > u ? t : u;
}

template <typename T>
inline const T& Min(const T& t, const T& u)
{
	return t < u ? t : u;
}

namespace essais_01
{
	template <typename T, unsigned int sz>
	Cessai_01<T, sz>::Cessai_01() : _sz(sz)
	{
		std::cout << "sz = " << _sz << std::endl;
	}

	template <typename T, unsigned int sz>
	void Cessai_01<T, sz>::setT(T t, unsigned int indice)
	{
		if (indice < _sz) { _t[indice] = t; }
	}

	template <typename T, unsigned int sz>
	void Cessai_01<T, sz>::affiche(unsigned int indice) 
	{ 
		if (indice < _sz) { std::cout << "t[" << indice << "] = " << _t[indice] << std::endl; }
	}
}

namespace essais_tests
{
	TestEssais::TestEssais(int fileRange = -1, std::string fileName = "dummy.txt") : _fileName (fileName)
	{
		testLireFichierTxt (fileRange, _fileName);

		// testEssaisFichier();

		//testSmartPtr();
	}

	void TestEssais::testEssais01(void)
	{
		essais_01::Cessai_01<int, 5> ce01;

		for (int i = 0; i < 7; ++i)
		{
			ce01.setT(i + (3 * -i) ^ 2, i);
			ce01.affiche(i);
		}
	}

	void TestEssais::testMinMax(void)
	{
		const int i = 11;
		const int j = 21;
		std::cout << "Min (" << i << ", " << j << ") = " << Min(i, j) << std::endl;
		std::cout << "Max (" << i << ", " << j << ") = " << Max(i, j) << std::endl;

		const double d = 11.34;
		const double e = 1.21;
		std::cout << "Min (" << d << ", " << e << ") = " << Min(d, e) << std::endl;
		std::cout << "Max (" << d << ", " << e << ") = " << Max(d, e) << std::endl;
	}

	void TestEssais::testTblStatiques(int argc, char** argv)
	{
		std::cout << "[" << f_string((argc > 1 ? argv[1] : nullptr)) << "]" << std::endl;
		char z[] = { 'Q', 'u', 'i', ' ', 'i', 'r', 'a', 's', '-', 't', 'u', ' ', 'v', 'o', 'i', 'r', ' ', 'd', 'e', 'm', 'a', 'i', 'n', ' ', '?', 0 };
		std::string s = { 'J', 'e', ' ', 'n', 'e', ' ', 's', 'u', 'i', 's', ' ', 'p', 'a', 's', ' ', 'd', 'e', ' ', 'c', 'e', 'u', 'x', ' ', 'l', 'A', ' ', '!' };
		std::cout << s << ", " << z << std::endl;
	}

	void TestEssais::testSmartPtr(void)
	{
		essais_smart_prt::Dummy_Essais_1 dummyEss_1;
	}

	void TestEssais::testEssaisFichier(void)
	{
		file_essais::EssaisFichier ef;
	}

	void TestEssais::testLireFichierTxt(int fileRange, std::string fileName)
	{
		afficheArgs(fileRange, fileName);
		file_essais::LireFichierTxt lft(fileName);
		std::cout << std::endl;
	}

	void TestEssais::afficheArgs(int argPosition, std::string argValue)
	{
		std::string argString = std::to_string(argPosition) + ". " + argValue;
		char* zTrait = new char [1 + argString.length()];
		memset(zTrait, 0, 1 + argString.length());
		memset(zTrait, '-', argString.length());
		std::cout << std::endl << argString << std::endl;
		std::cout << zTrait << std::endl;
	}
}

int main(int argc, char** argv)
{
	if (argc > 0)
	{
		for (int ii = 1; ii < argc; ++ii)
		{
			essais_tests::TestEssais te(ii, argv[ii]);
		}
	}

	return 0;
}
