#pragma once

template <class T>
class singleton
{
public:
	static T* get_singleton_ptr()
	{
		static T* ptr = new T;
		return ptr;
	}
};