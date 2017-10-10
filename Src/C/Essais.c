// Essais.c

# include <iostream>
# include <string>

# include "Essais.h"

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


int main(int argc, char** argv)
{
	std::cout << "[" << f_string ((argc > 1 ? argv [1] : nullptr)) << "]" << std::endl;
	char z[] = { 'Q', 'u', 'i', ' ', 'i', 'r', 'a', 's', '-', 't', 'u', ' ', 'v', 'o', 'i', 'r', ' ', 'd', 'e', 'm', 'a', 'i', 'n', ' ', '?', 0 };
	std::string s = {'J', 'e', ' ', 'n', 'e', ' ', 's', 'u', 'i', 's', ' ', 'p', 'a', 's', ' ', 'd', 'e', ' ', 'c', 'e', 'u', 'x', ' ', 'l', 'A', ' ', '!'};
	std::cout << s << ", " << z << std::endl;


	const int i = 11;
	const int j = 21;
	std::cout << "Min (" << i << ", " << j << ") = " << Min(i, j) << std::endl;
	std::cout << "Max (" << i << ", " << j << ") = " << Max(i, j) << std::endl;

	const double d = 11.34;
	const double e = 1.21;
	std::cout << "Min (" << d << ", " << e << ") = " << Min(d, e) << std::endl;
	std::cout << "Max (" << d << ", " << e << ") = " << Max(d, e) << std::endl;

	return 0;
}
