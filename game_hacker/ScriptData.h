#pragma once
#include "vector"
#include <string>

class script_data
{
public:
	script_data();
	script_data(const std::vector<uint8_t>&& data,std::string name);
	const std::string& get_name() const { return name_; }
	std::vector<uint8_t> get_data() const;
private:
	std::vector<uint8_t> data_;
	std::string name_;
};
