// Exple_1.c

# include <iostream>
# include <memory>
//# include <cstdio>
# include <cstring>

# include "Exple_1.h"

namespace exple_1
{
	Task::Task(int id) : mId(id)
	{
		std::cout << "Task::Constructor, mId = " << mId << std::endl;
	}

	Task::~Task()
	{
		std::cout << "Task::Destructor for mId " << mId << std::endl;
	}

	int Task::get_mId(void)
	{
		return mId;
	}
}

namespace exple_1
{
	Main::Main(int argc, char** argv) : _argc(argc), _argv(nullptr)
	{
		if (_argc > 0)
		{
			_argv = new char*[_argc];

			for (int i = 0; i < _argc; ++i)
			{
				int sz = 1 + strlen(argv[i]);
				_argv[i] = new char[sz];
				memset(_argv[i], 0, sz);
				memcpy(_argv[i], argv[i], -1 + sz);
			}
		}
	}

	Main::~Main()
	{
		if (_argc > 0)
		{
			for (int i = 0; i < _argc; ++i)
			{
				delete[] _argv[i];
				_argv[i] = nullptr;
			}
			delete[] _argv;
			_argv = nullptr;
		}
	}

	Main::Main(const Main & m)
	{
		if (this != &m)
		{
			if (_argc > 0)
			{
				for (int i = 0; i < _argc; ++i)
				{
					delete[] _argv[i];
					_argv[i] = nullptr;
				}
				delete[] _argv;
				_argv = nullptr;
			}

			_argc = m._argc;
			if (_argc > 0)
			{
				_argv = new char*[_argc];

				for (int i = 0; i < _argc; ++i)
				{
					int sz = 1 + strlen(m._argv[i]);
					_argv[i] = new char[sz];
					memset(_argv[i], 0, sz);
					memcpy(_argv[i], m._argv[i], -1 + sz);
				}
			}
		}
	}

	Main & Main::operator=(const Main & m)
	{
		if (this != &m)
		{
			if (_argc > 0)
			{
				for (int i = 0; i < _argc; ++i)
				{
					delete[] _argv[i];
					_argv[i] = nullptr;
				}
				delete[] _argv;
				_argv = nullptr;
			}

			_argc = m._argc;
			if (_argc > 0)
			{
				_argv = new char*[_argc];

				for (int i = 0; i < _argc; ++i)
				{
					int sz = 1 + strlen(m._argv[i]);
					_argv[i] = new char[sz];
					memset(_argv[i], 0, sz);
					memcpy(_argv[i], m._argv[i], -1 + sz);
				}
			}
		}
		return *this;
	}

	void Main::showArgs(void)
	{
		for (int i = 1; i < _argc; ++i)
		{
			std::cout << i << ". " << _argv[i] << std::endl;
		}
	}

	void Main::testUniquePtr(int value)
	{
		// Create a unique_ptr object through raw pointer
		std::unique_ptr<exple_1::Task> taskPtr(new exple_1::Task(_argc));

		//Access the element through unique_ptr
		int id = taskPtr->get_mId();

		std::cout << id << std::endl;

		for (int i = 1; i < _argc; ++i)
		{
		}
	}
}

/*
int main(int  argc, char** argv)
{
	// Create a unique_ptr object through raw pointer
	std::unique_ptr<exple_1::Task> taskPtr(new exple_1::Task(23));

	//Access the element through unique_ptr
	int id = taskPtr->get_mId();

	std::cout << id << std::endl;


	return 0;
}
**/
// http://thispointer.com/c11-unique_ptr-tutorial-and-examples/
