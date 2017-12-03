// Smart_Ptr.h

# ifndef SMART_PRT_H
# define SMART_PTR_H  (1)

#include <memory> // pour std::unique_ptr


namespace essais_smart_prt
{
	class Bclass
	{
	public :
		Bclass() = default;
		virtual ~Bclass() = default;
		Bclass(const Bclass& b) = default ;
		Bclass& operator = (const Bclass& b) = default;

		virtual void bar() ; // { std::cout << "Bclass::bar\n"; }
	private :
	};

	class Dclass : public Bclass
	{
	public :
		Dclass(std::string aName) ; // { std::cout << "Dclass::Dclass\n"; }
		~Dclass() ; // { std::cout << "Dclass::~Dclass\n"; }
		Dclass(const Dclass& d) = default;
		Dclass& operator = (const Dclass& d) = default;

		void bar() override ; // { std::cout << "Dclass::bar\n"; }
	private :
		std::string _aName;
	};

	class Dummy_Essais_1
	{
	public :
		Dummy_Essais_1 () ;
		~Dummy_Essais_1() = default ;
		Dummy_Essais_1(const Dummy_Essais_1& d) = default;
		Dummy_Essais_1& operator = (const Dummy_Essais_1& d) = default;

		// a function consuming a unique_ptr can take it by value or by rvalue reference
		std::unique_ptr<Dclass> pass_through(std::unique_ptr<Dclass> p) ;

	private :
	};
}

# endif   // SMART_PTR_H
