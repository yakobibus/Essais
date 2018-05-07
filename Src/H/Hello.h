/*
** Hello.h
**/

# ifndef _HELLO_H_
# define _HELLO_H_ (1)

namespace spc_hello {
    class Args {
    public :
        Args(int argc, char** argv) ;
        ~Args () ;
        Args (const Args& a) ;
        Args& operator = (const Args& a) ;
        //---
        void showArgs(void) ;
    private :
        int _argc = 0 ;
        char** _argv  = nullptr ;
    } ;

    class Hello 
    {
    public :
        Hello () ;
        ~Hello () ;
        Hello (const Hello& h) = default ;
        Hello& operator = (const Hello& h) = default ;
    private :
    };
}

# endif // _HELLO_H_
