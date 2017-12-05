// Essais.h

# ifndef ESSAIS_H
# define ESSAIS_H  (1)

namespace essais_01
{
	template <typename T, unsigned int sz>
	class Cessai_01
	{
	public :
		Cessai_01();
		~Cessai_01() = default;
		Cessai_01(const Cessai_01& c) = default;
		Cessai_01& operator = (const Cessai_01& c) = default;

		void setT(T t, unsigned int indice);
		void affiche(unsigned int indice);
	private :
		T _t[sz];
		const unsigned int _sz;
	};
}

namespace essais_tests
{
	class TestEssais
	{
	public :
		TestEssais();
		~TestEssais() = default;
		TestEssais(const TestEssais& te) = default;
		TestEssais& operator = (const TestEssais& te) = default;
		//
		void testEssais01(void);
		void testMinMax(void);
		void testTblStatiques(int argc, char** argv);
		void testSmartPtr(void);
		void testEssaisFichier(void);
	private :
	};
}

# endif // ESSAIS_H
