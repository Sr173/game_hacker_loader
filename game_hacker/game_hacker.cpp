// game_hacker.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
#include "lua.hpp"
#include "imgui.h"
#include "imgui_lua_bindings.h"
#include "ScriptManager.h"

#pragma comment(lib,"lua51.lib")
#pragma comment(lib,"luajit.lib")

auto main() noexcept -> int
{
	SCRIPT_MANAGER_INSTANCE->load_all_script("lua/", "");
	SCRIPT_MANAGER_INSTANCE->do_main_engine();
}
