/*
** Hello.c
**/

# include <iostream>

class Hello 
{
public :
  Hello ()
  {
    std::cout << "Hello World !" << std::endl ;
  }
  ~Hello ()
  {
    std::cout << "Bye, dear" << std::endl ;
  }
private :
};

int main (int argc, char** argv)
{
  Hello h;

  return 0 ;
}

