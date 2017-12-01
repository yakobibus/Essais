// Smart_Prt.c

# include <iostream>
# include <memory>   // pour std::unique_prt
# include <cassert>
# include <functional>
// # include <cstdio>
# include <vector>
# include <fstream>

# include "Smart_Ptr.h"

namespace essais_smart_prt
{
	void B::bar()
	{
		std::cout << "B::bar" << std::endl;
	}

	D::D()
	{
		std::cout << "D::D" << std::endl;
	}

	D::~D()
	{
		std::cout << "D::~D" << std::endl;
	}

	void D::bar() 
	{
		std::cout << "D::bar" << std::endl;
	}

	Dummy_Essais_1::Dummy_Essais_1 ()
	{
		std::cout << "unique ownership semantics demo\n";
		{
			auto p = std::make_unique<D>(); // p is a unique_ptr that owns a D
			auto q = pass_through(std::move(p));
			assert(!p); // now p owns nothing and holds a null pointer
			q->bar();   // and q owns the D object
		} // ~D called here

		std::cout << "Runtime polymorphism demo\n";
		{
			std::unique_ptr<B> p = std::make_unique<D>(); // p is a unique_ptr that owns a D
														  // as a pointer to base
			p->bar(); // virtual dispatch

			std::vector<std::unique_ptr<B>> v;  // unique_ptr can be stored in a container
			v.push_back(std::make_unique<D>());
			v.push_back(std::move(p));
			v.emplace_back(new D);
			for (auto& p : v) p->bar(); // virtual dispatch
		} // ~D called 3 times

		std::cout << "Custom deleter demo\n";
		std::ofstream("demo.txt") << 'x'; // prepare the file to read
		{
			std::unique_ptr<std::FILE, decltype(&std::fclose)> fp(std::fopen("demo.txt", "r"),
				&std::fclose);
			if (fp) // fopen could have failed; in which case fp holds a null pointer
				std::cout << (char)std::fgetc(fp.get()) << '\n';
		} // fclose() called here, but only if FILE* is not a null pointer
		  // (that is, if fopen succeeded)

		std::cout << "Custom lambda-expression deleter demo\n";
		{
			std::unique_ptr<D, std::function<void(D*)>> p(new D, [](D* ptr)
			{
				std::cout << "destroying from a custom deleter...\n";
				delete ptr;
			});  // p owns D
			p->bar();
		} // the lambda above is called and D is destroyed

		std::cout << "Array form of unique_ptr demo\n";
		{
			std::unique_ptr<D[]> p{ new D[3] };
		} // calls ~D 3 times
	}

	std::unique_ptr<D> Dummy_Essais_1::pass_through(std::unique_ptr<D> p)
	{
		p->bar();
		return p;
	}
}