// Music.c

# include <iostream>

# include "Music.h"

namespace just_music
{
	Song::Song(const char* singer, const char* title)
	{
		std::cout << "ctor::Song" << std::endl;
	}

	Song::~Song()
	{
		std::cout << "dtor::Song" << std::endl;
	}

	Song::Song(const Song & s)
	{
		std::cout << "cpy ctor::Song" << std::endl;
	}

	Song & Song::operator=(const Song & s)
	{
		std::cout << "operator = ::Song" << std::endl;
		return *this;
	}
}
