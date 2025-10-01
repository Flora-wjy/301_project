#include <iostream>
#include <fstream>
#include <bitset>
#include <iomanip>
#include <string>

//don't move this file out of this folder cuz it breaks stuff
// g++ -std=c++17 -o compare compareFiles.cpp (shouldn't need to run again unless this file is modified)
// ./compare-test/compare file1.bin Testcases/GoldBinaries/file2.bin


int main(int argc, char* argv[]) {
    if (argc != 3) {
        std::cerr << "Usage: " << argv[0] << " <file1> <file2>" << std::endl;
        return 1;
    }

    std::string file1name = argv[1];
    std::string file2name = argv[2];

    std::ifstream file1(file1name, std::ios::in | std::ios::binary);
    std::ifstream file2(file2name, std::ios::in | std::ios::binary);

    if (!file1.is_open()) {
        std::cerr << "Error opening file1: " << file1name << std::endl;
        return 1;
    }
    if (!file2.is_open()) {
        std::cerr << "Error opening file2: " << file2name << std::endl;
        return 1;
    }

    int buffer1 = 0, buffer2 = 0;
    size_t index = 0;
    bool differences_found = false;

    while (true) {
        bool read1 = static_cast<bool>(file1.read(reinterpret_cast<char*>(&buffer1), sizeof(int)));
        bool read2 = static_cast<bool>(file2.read(reinterpret_cast<char*>(&buffer2), sizeof(int)));

        if (!read1 && !read2) {
            break; // both EOF
        }

        if (read1 && read2) {
            if (buffer1 != buffer2) {
                differences_found = true;
                std::cout << "Difference at index " << index << ":\n";
                std::cout << "  File1: " 
                          << std::bitset<32>(buffer1) << " "
                          << std::setw(8) << std::setfill('0') << std::hex << buffer1 
                          << " " << std::dec << buffer1 << "\n";
                std::cout << "  File2: " 
                          << std::bitset<32>(buffer2) << " "
                          << std::setw(8) << std::setfill('0') << std::hex << buffer2 
                          << " " << std::dec << buffer2 << "\n";
            }
        } else if (read1 && !read2) {
            differences_found = true;
            std::cout << "Extra data in File1 at index " << index << ":\n";
            std::cout << "  File1: " 
                      << std::bitset<32>(buffer1) << " "
                      << std::setw(8) << std::setfill('0') << std::hex << buffer1 
                      << " " << std::dec << buffer1 << "\n";
            std::cout << "  File2: <EOF>\n";
        } else if (!read1 && read2) {
            differences_found = true;
            std::cout << "Extra data in File2 at index " << index << ":\n";
            std::cout << "  File1: <EOF>\n";
            std::cout << "  File2: " 
                      << std::bitset<32>(buffer2) << " "
                      << std::setw(8) << std::setfill('0') << std::hex << buffer2 
                      << " " << std::dec << buffer2 << "\n";
        }

        index++;
    }

    file1.close();
    file2.close();

    if (!differences_found) {
        std::cout << "Files are identical." << std::endl;
    }

    return 0;
}
