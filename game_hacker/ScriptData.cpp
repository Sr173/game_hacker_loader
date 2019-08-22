#include "ScriptData.h"
#include "aes.hpp"
#include "ScriptManager.h"
//#include "LuaCall.hpp"

script_data::script_data()
{
}

script_data::script_data(const std::vector<uint8_t>&& data, std::string name)
	:data_(data) , name_(name)
{

}


std::vector<uint8_t> script_data::get_data() const
{
	std::vector<uint8_t> buffer;
	buffer.resize(data_.size());
	buffer.assign(std::begin(data_),std::end(data_));
	AES_ctx ctx;
	AES_init_ctx_iv(&ctx, SCRIPT_MANAGER_INSTANCE->get_ase_key_().data(), SCRIPT_MANAGER_INSTANCE->get_ase_iv_().data());
	AES_CTR_xcrypt_buffer(&ctx, buffer.data(), buffer.size());
	return std::move(buffer);
}
