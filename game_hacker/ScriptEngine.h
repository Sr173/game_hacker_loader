#pragma once
#include <memory>
#include "ScriptData.h"

struct lua_State;

class script_engine
{
public:
public:
	static const int is_support_multi_thread = 1 << 1;
	script_engine(lua_State* script_status);
	~script_engine();
public:
	/*
	* @樊崇浩
	* 创建一个新的脚本解释引擎，创建出来的脚本解释器同时只能有一个线程调用！
	* 返回值可能为空所以要校验一下
	*/
	static std::shared_ptr<script_engine> create_script_engine(const int flag = 0);

	void do_file(const char* file);

	int do_script(const script_data& data);

	const std::string& get_last_error_message() const { return error_message; };

	int load_buffer(const script_data& data) const;

	static void lua_new_state_callback(lua_State* from, lua_State* new_s);

	static int script_loader(lua_State* loader);

	const std::string& get_last_error_message();
private:
	lua_State* lua_vm_;
	std::string error_message;
};

