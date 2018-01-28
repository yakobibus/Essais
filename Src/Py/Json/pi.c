# include <iostream>
# include <cmath>
# include <iomanip>
# include <ctime>

double pi (long n)
{
      double d = 0.0;

     for(int i = 1 ; i <= n ; ++i)
     {
         d += (1.0/( double)std::pow(i, 2)) ;
     }
     return std::pow((d * 6), .5) ;
     //return (sum([1/n**2 for n in range(1,n)])*6)**0.5
}

int main(int argc, char** argv)
{
    long n = atoi(argv[1]);
    const clock_t begin_time = clock();
    std::cout<<std::fixed;
    std::setprecision(15);
    std::cout << "pi = " <<( double) pi(n) << std::endl ;
    std::cout << "duree : "<<float( clock () - begin_time ) /  CLOCKS_PER_SEC << std::endl;
    return 0;
}

