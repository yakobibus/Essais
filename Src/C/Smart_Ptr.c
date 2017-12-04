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
	void Bclass::bar()
	{
		std::cout << "Bclass::bar" << std::endl;
	}

	Dclass::Dclass(std::string aName = "Smith") : _aName(aName)
	{
		std::cout << "Dclass::Dclass. My name is " << _aName << "." << std::endl;
	}

	Dclass::~Dclass()
	{
		std::cout << "Dclass::~Dclass, an end for " << _aName << ", is it not ?" << std::endl;
	}

	void Dclass::bar() 
	{
		std::cout << "Dclass::bar" << (_aName == "Smith" ? "" : " ... for <" + _aName + ">") << std::endl;
	}

	Dummy_Essais_1::Dummy_Essais_1 ()
	{
		std::cout << "unique ownership semantics demo\n";
		{
			auto p = std::make_unique<Dclass> ( "P, a unique_ptr that owns a Dclass" ); // p is a unique_ptr that owns a D
			auto q = pass_through(std::move(p));
			assert(!p); // now p owns nothing and holds a null pointer
			std::cout << "Here I'm ... [" << std::endl;
			q->bar();   // and q owns the D object
			std::cout << "], but no more" << std::endl;
		} // ~D called here
		std::cout << std::endl;

		std::cout << "Runtime polymorphism demo\n";
		{
			std::unique_ptr<Bclass> p = std::make_unique<Dclass>("P_an_rtPolymorph ptr"); // p is a unique_ptr that owns a Dclass
														  // as a pointer to base
			p->bar(); // virtual dispatch

			std::vector<std::unique_ptr<Bclass>> v;  // unique_ptr can be stored in a container
			v.push_back(std::make_unique<Dclass>("mkUnique rtPolymorphism"));
			v.push_back(std::move(p));
			v.emplace_back(new (Dclass)("z....new....z"));
			for (auto& p : v) { p->bar(); } // virtual dispatch
		} // ~D called 3 times
		std::cout << std::endl;

		std::cout << "Custom deleter demo\n";
		std::ofstream("demo.txt") << "x files series and Mr Mulder, not Bond, Fox Mulder.\n- Hi Fox.\n- Hi James"
			"For a double 0 or comming from the next galaxy, we're a mystery" << std::endl ; // prepare the file to read
		{
			std::unique_ptr<std::FILE, decltype(&std::fclose)> fp(std::fopen("demo.txt", "r"), &std::fclose);
			if (fp)  // fopen could have failed; in which case fp holds a null pointer
			{
				while (char c = (char)std::fgetc(fp.get())) 
				{
					if (c == EOF)
					{
						break; 
					} 
					std::cout << c;			
				} 
				std::cout << std::endl;
			}
		} // fclose() called here, but only if FILE* is not a null pointer
		  // (that is, if fopen succeeded)
		std::cout << std::endl;

		std::cout << "Custom lambda-expression deleter demo\n";
		{
			std::unique_ptr<Dclass, std::function<void(Dclass*)>> p(new Dclass, [](Dclass* ptr)
			{
				std::cout << "destroying from a custom deleter...\n";
				delete ptr;
			});  // p owns D
			p->bar();
		} // the lambda above is called and D is destroyed
		std::cout << std::endl;

		std::cout << "Array form of unique_ptr demo\n";
		{
			std::unique_ptr<Dclass[]> p{ new Dclass[3] };
		} // calls ~D 3 times
		std::cout << std::endl;
	}

	std::unique_ptr<Dclass> Dummy_Essais_1::pass_through(std::unique_ptr<Dclass> p)
	{
		std::cout << "I'm passing through ..." << std::endl;
		p->bar();
		std::cout << "... done" << std::endl;
		return p;
	}
}
