// game_hacker.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
#include "lua.hpp"
#include "imgui.h"
#include "imgui_lua_bindings.h"

#pragma comment(lib,"lua51.lib")
#pragma comment(lib,"luajit.lib")

auto main() noexcept -> int
{
	const auto lua_main_vm = luaL_newstate();
	luaL_openlibs(lua_main_vm);
	load_imgui_bindings(lua_main_vm);
	if (luaL_dofile(lua_main_vm,"script/main.lua"))
	{
		std::cout << luaL_checkstring(lua_main_vm, 1) << std::endl;
	}

	return 0;
}
