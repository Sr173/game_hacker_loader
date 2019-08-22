#include "ScriptManager.h"
#include "ScriptEngine.h"
#include "aes.hpp"
#include <fstream>
#include "windows.h"

int script_manager::load_all_script(std::string local_path, std::string check_server_path)
{
	uint8_t key[] = { 0x2b, 0x7e, 0x15, 0x16, 0x28, 0xae, 0xd2, 0xa6, 0xab, 0xf7, 0x15, 0x88, 0x09, 0xcf, 0x4f, 0x3c, 0x2b, 0x7e, 0x15, 0x16, 0x28, 0xae, 0xd2, 0xa6, 0xab, 0xf7, 0x15, 0x88, 0x09, 0xcf, 0x4f, 0x3c };
	uint8_t iv[] = { 0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7, 0xf8, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xfe, 0xff };
	aes_key_.resize(sizeof(key));
	memcpy(aes_key_.data(), key, sizeof(key));
	aes_iv_.resize(sizeof(iv));
	memcpy(aes_iv_.data(), iv, sizeof(iv));

	local_script_path_ = local_path;
#if defined _DEBUG
	traverse_local_directory(local_script_path_.data());
#endif
	return 0;
}

void script_manager::do_main_engine()
{
	main_engine_ = script_engine::create_script_engine(0);
#if defined _DEBUG
	main_engine_->do_script(script_data_["main"]);
#endif

}

#if defined (_DEBUG)
void script_manager::traverse_local_directory(std::string dir)
{
	WIN32_FIND_DATAA FindFileData;
	HANDLE hFind = INVALID_HANDLE_VALUE;
	const std::string traverse_path = std::string(dir) + "/*";
	wchar_t DirSpec[MAX_PATH];                  //定义要遍历的文件夹的目录
	DWORD dwError;

	hFind = FindFirstFileA(traverse_path.data(), &FindFileData);          //找到文件夹中的第一个文件

	if (hFind == INVALID_HANDLE_VALUE)                               //如果hFind句柄创建失败，输出错误信息
	{
		FindClose(hFind);
		return;
	}
	else
	{
		while (FindNextFileA(hFind, &FindFileData) != 0)                            //当文件或者文件夹存在时
		{
			if ((FindFileData.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY) != 0 && strcmp(FindFileData.cFileName, ".") == 0 || strcmp(FindFileData.cFileName, "..") == 0)        //判断是文件夹&&表示为"."||表示为"."
			{
				continue;
			}
			if ((FindFileData.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY) != 0)      //判断如果是文件夹
			{
				if (dir == "") dir = ".";
				std::string next_dir = std::string(dir) + "/" + std::string(FindFileData.cFileName);
				traverse_local_directory(next_dir.data());                                  //实现递归调用
			}
			if ((FindFileData.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY) == 0)    //如果不是文件夹
			{
				auto file_name = std::string(FindFileData.cFileName);
				if (file_name.find(".lua") != std::string::npos) {
					auto script_name = dir.substr(local_script_path_.length()) + "/" + file_name.substr(0,file_name.length() - 4);
					script_name = script_name.substr(1);
					load_local_file_to_memory_(script_name,dir  + "/" + FindFileData.cFileName);
				}
			}
		}
		FindClose(hFind);
	}
}

void script_manager::load_local_file_to_memory_(std::string file, std::string full_path)
{
	std::ifstream infile;
	infile.open(full_path, std::ios::in | std::ios::binary | std::ios::ate);
	std::vector<uint8_t> data(infile.tellg());
	const int file_size = infile.tellg();
	infile.seekg(0, std::ios::beg);
	if (file_size > 0) {
		infile.read(reinterpret_cast<char*>(data.data()), file_size);
		AES_ctx ctx;
		AES_init_ctx_iv(&ctx, aes_key_.data(), aes_iv_.data());
		AES_CTR_xcrypt_buffer(&ctx, data.data(), data.size());
		script_data_[file] = script_data(std::move(data), file);
	}
	infile.close();
}
#endif
