// Exple_1.h

# ifndef EXPLE_1_H
# define EXPLE_1_H  (1)

  namespace exple_1
  {
    class Task
    {
    public :
    	Task(int id) ;      
    	~Task() ;     
      Task (const Task& t) = default ;      
      Task& operator = (const Task& t) = default ;
      
      int get_mId(void) ;
    private :
    	int mId;
    };
  
    class Main
    {
    public :
      Main (int argc, char** argv);
      ~Main();
      Main(const Main& m) ;
      Main& operator = (const Main& m);
      
      void showArgs (void);
	  void testUniquePtr(int value);
    private :
      int _argc ;
      char** _argv ;
    };
  } 
  
# endif  // EXPLE_1_H
