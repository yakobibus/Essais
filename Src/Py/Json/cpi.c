# include <stdio.h>
# include <math.h>
# include <time.h>
# include <string.h>
# include <stdlib.h>


  double pi (long n)
 {
      double d = 0.0;

     for(int i = 1 ; i <= n ; ++i)
     {
         d += (1.0/( double) pow(i, 2)) ;
     }
     return (pow((d * 6) , .5)) ;
     //return (sum([1/n**2 for n in range(1,n)])*6)**0.5
 }

int main(int argc, char** argv)
{
    long n = atoi(argv[1]);
    const clock_t begin_time = clock();
    printf("pi = %.22lf\n", ( double) pi(n) ) ;
    printf("duree : %f\n", (float)( clock () - begin_time ) /  CLOCKS_PER_SEC );
    return 0;
}

