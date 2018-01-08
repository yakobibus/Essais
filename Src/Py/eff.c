#include <iostream>

class Calcul
{
public :
  Calcul (double d1 = 3.11, double d2 = 2.08) : _d1(d1), _d2(d2)
  {
    std::cout << _d1 << " + " << _d2 << " = " << _d1 + _d2 << std::endl ;
  }
  ~Calcul () = default ;
  Calcul (const Calcul&) = default ;
  Calcul& operator= (const Calcul&) = default ;
private :
  double _d1 ;
  double _d2 ;
};

int main (int argc, char** argv)
{
  Calcul c ;
  return 0;
}


