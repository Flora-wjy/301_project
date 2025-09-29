#ifndef __PROJECT1_CPP__
#define __PROJECT1_CPP__

#include "project1.h"
#include <vector>
#include <string>
#include <unordered_map>
#include <iostream>
#include <sstream>
#include <fstream>

int main(int argc, char* argv[]) {
    if (argc < 4) // Checks that at least 3 arguments are given in command line
    {
        std::cerr << "Expected Usage:\n ./assemble infile1.asm infile2.asm ... infilek.asm staticmem_outfile.bin instructions_outfile.bin\n" << std::endl;
        exit(1);
    }
    //Prepare output files
    std::ofstream inst_outfile, static_outfile;
    static_outfile.open(argv[argc - 2], std::ios::binary);
    inst_outfile.open(argv[argc - 1], std::ios::binary);
    std::vector<std::string> instructions;

    /**
     * Phase 1:
     * Read all instructions, clean them of comments and whitespace DONE
     * TODO: Determine the numbers for all static memory labels
     * (measured in bytes starting at 0)
     * TODO: Determine the line numbers of all instruction line labels
     * (measured in instructions) starting at 0
    */

    //For each input file:
    for (int i = 1; i < argc - 2; i++) {
        std::ifstream infile(argv[i]); //  open the input file for reading
        if (!infile) { // if file can't be opened, need to let the user know
            std::cerr << "Error: could not open file: " << argv[i] << std::endl;
            exit(1);
        }

        std::string str;
        while (getline(infile, str)){ //Read a line from the file
            str = clean(str); // remove comments, leading and trailing whitespace
            if (str == "") { //Ignore empty lines
                continue;
            }
            instructions.push_back(str); // TODO This will need to change for labels
        }
        infile.close();
    }

    std::vector<std::string> memory;
    std::vector<int> memory_idx;

    std::vector<std::string> main;
    std::vector<int> main_idx;    
    int inx_main = 0;
    int inx_memory = 0;
    for (const auto& instruction : instructions) {  
        if (instruction.find('.') == std::string::npos) {             // I DON'T UNDETSTAND THIS PART!!!!!!!!!
            if (instruction.find(':') != std::string::npos) {
                main_idx.push_back(inx_main);
            } else {
                main.push_back(instruction);
            }
            ++inx_main;
        } else {
            if (instruction.find(':') != std::string::npos) {
                memory.push_back(instruction);
                memory_idx.push_back(inx_memory);
            }
            ++inx_memory;
        }
        
    }

    // Print out main and memory vectors to verify correct separation
    for (const auto& memory_line : memory) { 
        std::cout << memory_line << std::endl;
    }
    std::cout << "-----" << std::endl;    
    for (const auto& main_line : main) { 
        std::cout << main_line << std::endl;
    }
    std::cout << "-----" << std::endl;
    for (const auto& idx : memory_idx) { 
        std::cout << idx << std::endl;
    }
    std::cout << "-----" << std::endl;
    for (const auto& idx : main_idx) { 
        std::cout << idx << std::endl;
    }
 
        

    /** Phase 2
     * Process all static memory, output to static memory file
     * TODO: All of this
     */

    /** Phase 3
     * Process all instructions, output to instruction memory file
     * TODO: Almost all of this, it only works for adds
     */
    for(std::string inst : instructions) {
        std::vector<std::string> terms = split(inst, WHITESPACE+",()");
        std::string inst_type = terms[0];
        if (inst_type == "add") {
            int result = encode_Rtype(0,registers[terms[2]], registers[terms[3]], registers[terms[1]], 0, 32);
            write_binary(encode_Rtype(0,registers[terms[2]], registers[terms[3]], registers[terms[1]], 0, 32),inst_outfile);
        }
        else if (inst_type == "sub") {
            int result = encode_Rtype(0,registers[terms[2]], registers[terms[3]], registers[terms[1]], 0, 34);
            write_binary(encode_Rtype(0,registers[terms[2]], registers[terms[3]], registers[terms[1]], 0, 34),inst_outfile);
        }
        else if (inst_type == "mult") {
            int result = encode_Rtype(0,registers[terms[1]], registers[terms[2]], 0, 0, 24);
            write_binary(encode_Rtype(0,registers[terms[1]], registers[terms[2]], 0, 0, 24),inst_outfile);
        }
        else if (inst_type == "div") {
            int result = encode_Rtype(0,registers[terms[1]], registers[terms[2]], 0, 0, 26);
            write_binary(encode_Rtype(0,registers[terms[1]], registers[terms[2]], 0, 0, 26),inst_outfile);
        }
        else if (inst_type == "mflo") {
            int result = encode_Rtype(0, 0, 0, registers[terms[1]], 0, 18);
            write_binary(encode_Rtype(0, 0, 0, registers[terms[1]], 0, 18),inst_outfile);
        }
        else if (inst_type == "mfhi") {
            int result = encode_Rtype(0, 0, 0, registers[terms[1]], 0, 16);
            write_binary(encode_Rtype(0, 0, 0, registers[terms[1]], 0, 16),inst_outfile);
        }
        else if (inst_type == "sll") {
            int result = encode_Rtype(0, 0, registers[terms[2]], registers[terms[1]], registers[terms[3]], 0);
            write_binary(encode_Rtype(0, 0, registers[terms[2]], registers[terms[1]], registers[terms[3]], 0),inst_outfile);
        }
        else if (inst_type == "srl") {
            int result = encode_Rtype(0, 0, registers[terms[2]], registers[terms[1]], registers[terms[3]], 2);
            write_binary(encode_Rtype(0, 0, registers[terms[2]], registers[terms[1]], registers[terms[3]], 2),inst_outfile);
        }
        else if (inst_type == "slt") {
            int result = encode_Rtype(0, registers[terms[2]], registers[terms[3]], registers[terms[1]], registers[terms[3]], 42);
            write_binary(encode_Rtype(0, registers[terms[2]], registers[terms[3]], registers[terms[1]], registers[terms[3]], 42),inst_outfile);
        }
        else if (inst_type == "jr") {
            int result = encode_Rtype(0, registers[terms[1]], 0, 0, 0, 8);
            write_binary(encode_Rtype(0, registers[terms[1]], 0, 0, 0, 8),inst_outfile);
        }
        else if (inst_type == "jalr") {
            int result = encode_Rtype(0, registers[terms[1]], 0, registers[terms[2]], 0, 9);
            write_binary(encode_Rtype(0, registers[terms[1]], 0, registers[terms[2]], 0, 9),inst_outfile);
        }
        else if (inst_type == "syscall") {
            // 
        }
    }
}

#endif