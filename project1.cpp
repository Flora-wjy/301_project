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


 // FLORA"S CODE STARTS HERE   
    std::unordered_map<std::string, std::vector<std::string>> memory;
    // std::vector<int> memory_idx;         REMOVING THIS, unordered map instead
    std::unordered_map<std::string, int> memory_label;    
    std::vector<std::string> main;
    // std::vector<int> main_idx;           REMOVING THIS, underored map instead
    std::unordered_map<std::string, int> main_label;    
    int main_inx = 0;
    int memory_inx = 0;
    for (const auto& instruction : instructions) {  
        if (instruction.find('.') == std::string::npos) {   // main          // I DON'T UNDETSTAND THIS PART!!!!!!!!!
            size_t colon_pos = instruction.find(':');
            if (colon_pos != std::string::npos) {
                main_label[instruction.substr(0, colon_pos)] = main_inx;
            } else {
                main.push_back(instruction);
                ++main_inx;
            }
        } else {          
            size_t colon_pos = instruction.find(':');                                  // memory   
            if (colon_pos != std::string::npos) {
                std::vector<std::string> terms = split(instruction.substr(colon_pos+1), WHITESPACE);
                std::string directive = terms[0];
                std::vector<std::string> contents(terms.begin() + 1, terms.end());
                // // TEMP: Print out the directive and contents to verify correct parsing
                // std::cout << directive << ": " << std::endl;
                // for (const auto& term : contents) {
                //     std::cout << term << std::endl;
                // }
                std::string label = instruction.substr(0, colon_pos);
                memory[label] = contents;
                memory_label[label] = memory_inx;
                memory_inx = memory_inx + 4*contents.size();
            }
        }
    }


    // TEMP: Print out main and memory vectors to verify correct separation
    std::cout << "--- FOR ADELE ---" << std::endl;    
    std::cout << "**memory: unordered map (label: vector of strings)**" << std::endl; 
    for (const auto& pair : memory) {
        std::cout << pair.first << ":" << std::endl;
        for (const auto& memory_line : pair.second) { 
            std::cout << memory_line << std::endl;
        }
    }
    std::cout << "**memory_label: unordered map (label: index)**" << std::endl;
    for (const auto& pair : memory_label) {
        std::cout << pair.first << ": " << pair.second << std::endl;
    }
    std::cout << "--- FOR LENA ---" << std::endl;    
    std::cout << "**vector of strings**" << std::endl; 
    for (const auto& main_line : main) { 
        std::cout << main_line << std::endl;
    }
    std::cout << "**unordered map (label: index)**" << std::endl;
    for (const auto& pair : main_label) {
        std::cout << pair.first << " : " << pair.second << std::endl;
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
        // R-type
        if (inst_type == "add") {
            int result = encode_Rtype(0,registers[terms[2]], registers[terms[3]], registers[terms[1]], 0, 32);
            write_binary(result, inst_outfile);
        }
        else if (inst_type == "sub") {
            int result = encode_Rtype(0,registers[terms[2]], registers[terms[3]], registers[terms[1]], 0, 34);
            write_binary(result, inst_outfile);
        }
        else if (inst_type == "mult") {
            int result = encode_Rtype(0,registers[terms[1]], registers[terms[2]], 0, 0, 24);
            write_binary(result, inst_outfile);
        }
        else if (inst_type == "div") {
            int result = encode_Rtype(0,registers[terms[1]], registers[terms[2]], 0, 0, 26);
            write_binary(result, inst_outfile);
        }
        else if (inst_type == "mflo") {
            int result = encode_Rtype(0, 0, 0, registers[terms[1]], 0, 18);
            write_binary(result, inst_outfile);
        }
        else if (inst_type == "mfhi") {
            int result = encode_Rtype(0, 0, 0, registers[terms[1]], 0, 16);
            write_binary(result, inst_outfile);
        }
        else if (inst_type == "sll") {
            int result = encode_Rtype(0, 0, registers[terms[2]], registers[terms[1]], std::stoi(terms[3]), 0);
            write_binary(result, inst_outfile);
        }
        else if (inst_type == "srl") {
            int result = encode_Rtype(0, 0, registers[terms[2]], registers[terms[1]], std::stoi(terms[3]), 2);
            write_binary(result, inst_outfile);
        }
        else if (inst_type == "slt") {
            int result = encode_Rtype(0, registers[terms[2]], registers[terms[3]], registers[terms[1]], 0, 42);
            write_binary(result, inst_outfile);
        }
        else if (inst_type == "jr") {
            int result = encode_Rtype(0, registers[terms[1]], 0, 0, 0, 8);
            write_binary(result, inst_outfile);
        }
        else if (inst_type == "jalr") {
            if (terms.size() == 2) {
                int result = encode_Rtype(0, registers[terms[1]], 0, 31, 0, 9);
                write_binary(result, inst_outfile);
            } else {
                int result = encode_Rtype(0, registers[terms[1]], 0, registers[terms[2]], 0, 9);
                write_binary(result, inst_outfile);
            }
        }
        else if (inst_type == "syscall") {
            int result = encode_Rtype(0, 0, 0, 26, 0, 12);
            write_binary(result, inst_outfile);
        }
        // I-type
        else if (inst_type == "addi") {
            int result = encode_Itype(8, registers[terms[2]], registers[terms[1]], std::stoi(terms[3]));
            write_binary(result, inst_outfile);
        }
        else if (inst_type == "beq") {
            int offset = main_label[terms[3]] - (main_label[terms[0]] + 1); // or pc? pc = main_label[terms[0]]
            int result = encode_Itype(4, registers[terms[1]], registers[terms[2]], offset);
            write_binary(result, inst_outfile);
        }
        else if (inst_type == "bne") {
            int offset = main_label[terms[3]] - (main_label[terms[0]] + 1); 
            int result = encode_Itype(5, registers[terms[1]], registers[terms[2]], offset);
            write_binary(result, inst_outfile);
        }
        else if (inst_type == "lw") {
            //
        }

    }
}

#endif