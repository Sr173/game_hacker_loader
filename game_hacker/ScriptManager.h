#pragma once
#include "Singleton.hpp"
#include "ScriptData.h"
#include <map>
#include <memory>

#define _DEBUG

class script_engine;

class script_manager
{
public:
	using singleton = singleton<script_manager>;
	int load_all_script(std::string local_path, std::string check_server_path);

	void do_main_engine();

	const std::vector<uint8_t>& get_ase_key_() const { return aes_key_; }

	const std::vector<uint8_t>& get_ase_iv_() const { return aes_iv_; }

	const script_data const* get_script_data(std::string name)
	{
		if (script_data_.count(name))
		{
			return &script_data_[name];
		}
		return nullptr;
	}

#if defined (_DEBUG)
public:
	void traverse_local_directory(std::string dir);
private:
	void load_local_file_to_memory_(std::string file,std::string full_path);
#endif
private:
	/*
	 * @樊崇浩
	 * 存储目前加载的所有脚本
	 */
	std::map<std::string, script_data> script_data_;
	std::shared_ptr<script_engine> main_engine_;
	std::string local_script_path_;
	std::vector<uint8_t> aes_key_;
	std::vector<uint8_t> aes_iv_;
};

#define SCRIPT_MANAGER_INSTANCE script_manager::singleton::get_singleton_ptr()