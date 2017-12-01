// Smart_Ptr.h

# ifndef SMART_PRT_H
# define SMART_PTR_H  (1)

#include <memory> // pour std::unique_ptr


namespace essais_smart_prt
{
	class B
	{
	public :
		B() = default;
		virtual ~B() = default;
		B(const B& b) = default ;
		B& operator = (const B& b) = default;

		virtual void bar() ; // { std::cout << "B::bar\n"; }
	private :
	};

	class D : public B
	{
	public :
		D() ; // { std::cout << "D::D\n"; }
		~D() ; // { std::cout << "D::~D\n"; }
		D(const D& d) = default;
		D& operator = (const D& d) = default;

		void bar() override ; // { std::cout << "D::bar\n"; }
	private :
	};

	class Dummy_Essais_1
	{
	public :
		Dummy_Essais_1 () ;
		~Dummy_Essais_1() = default ;
		Dummy_Essais_1(const Dummy_Essais_1& d) = default;
		Dummy_Essais_1& operator = (const Dummy_Essais_1& d) = default;

		// a function consuming a unique_ptr can take it by value or by rvalue reference
		std::unique_ptr<D> pass_through(std::unique_ptr<D> p) ;

	private :
	};
}

# endif   // SMART_PTR_H
