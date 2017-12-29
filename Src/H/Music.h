// Music.h

# ifndef MUSIC_H

namespace just_music
{
	class Song
	{
	public :
		Song(const char* singer, const char* title);
		~Song();
		Song(const Song& s);
		Song& operator = (const Song& s);
	private :
		char* _title;
		char* _singer;
	};
}

# endif // MUSIC_H

// http://thispointer.com/c11-unique_ptr-tutorial-and-examples/
// https://msdn.microsoft.com/fr-fr/library/hh279669.aspx
