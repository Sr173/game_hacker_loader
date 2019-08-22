#include "ScriptEngine.h"
#include "ScriptManager.h"
#include <lua.hpp>
#include <algorithm>
#include <windows.h>

extern  "C" {
#include "lanes.h"
#include "compat.h"
}

#pragma  comment (lib,"../third_party/luajit/src/lua51.lib")
#pragma  comment (lib,"../third_party/lanes/Release/core.lib")

//#pragma  comment (lib,"../third_party/luajit/src/luajit.lib")

script_engine::script_engine(lua_State* script_status)
	:lua_vm_(script_status)
{
	lua_lanes_set_create_callback(script_engine::lua_new_state_callback);
}

script_engine::~script_engine()
{
	if (lua_vm_)
		lua_close(lua_vm_);
}

std::shared_ptr<script_engine> script_engine::create_script_engine(const int flag)
{
	auto vm = luaL_newstate();
	if (vm == nullptr)
	{
		return nullptr;
	}

	luaL_openlibs(vm);
	lua_new_state_callback(nullptr, vm);

	if (flag == 0 || (flag & is_support_multi_thread))
	{
		luaL_requiref(vm, "lanes.core", luaopen_lanes_core, 0);
	}

	return std::make_shared<script_engine>(vm);
}

void script_engine::do_file(const char* file)
{
	luaL_dofile(lua_vm_, file);
}

int script_engine::do_script(const script_data& data)
{
	int code = load_buffer(data);
	if ((code = lua_pcall(lua_vm_, 0, LUA_MULTRET, 0)))
	{
		error_message = lua_tostring(lua_vm_, -1);
	}
	return code;
}

int script_engine::load_buffer(const script_data& data) const
{
	const auto&& s_data = data.get_data();
	return luaL_loadbuffer(lua_vm_, reinterpret_cast<const char*>(s_data.data()), s_data.size(), data.get_name().data());
}

void script_engine::lua_new_state_callback(lua_State* from, lua_State* new_s)
{
	lua_register(new_s, "my_loader", &script_engine::script_loader);
	std::string     str;
	str += "table.insert(package.loaders,   2, my_loader) \n";   // Older than lua v5.2
	//str += "table.insert(package.searchers, 2, my_loader) \n";
	luaL_dostring(new_s, str.c_str());
}

int script_engine::script_loader(lua_State* loader)
{
	const char* name = luaL_checkstring(loader, 1);
	std::string script_name(name);

	std::replace(script_name.begin(), script_name.end(), '.', '/');

	const auto script = SCRIPT_MANAGER_INSTANCE->get_script_data(script_name.data());
	if (script == nullptr) {
		MessageBoxA(nullptr, script_name.data(), "加载脚本失败", 0);
		return 0;
	}
	const auto script_data = script->get_data();
	if (script_data.size() > 0)
	{
		if (luaL_loadbuffer(loader, (char*)script_data.data(), script_data.size(), script_name.data()))
		{
			MessageBoxA(nullptr, lua_tostring(loader, -1), "加載脚本時遇到錯誤", 0);
			lua_pop(loader, 1);
		}
		return 1;
	}
	return 0;
}

const std::string& script_engine::get_last_error_message()
{
	return error_message;
}

