#ifndef __PROJECT1_CPP__
#define __PROJECT1_CPP__

#include "project1.h"
#include <vector>
#include <string>
#include <unordered_map>
#include <iostream>
#include <sstream>
#include <fstream>
#include <stdexcept>

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

    std::vector<std::string> memory;
    std::unordered_map<std::string, int> memory_label;
    std::unordered_map<std::string, int> instruction_label;    
    int instruction_inx = 0;
    int memory_inx = 0;

    /**
     * Phase 1:
     * Read all instructions, clean them of comments and whitespace DONE
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
            
            if (str.find(".") != std::string::npos) {           // Memory
                size_t colon_pos = str.find(':');

                if (colon_pos != std::string::npos) {           // Find labels
                    std::string label = str.substr(0, colon_pos);
                    std::vector<std::string> terms = split(str.substr(colon_pos+1), WHITESPACE);
                    std::string directive = terms[0];
                    memory_label[label] = memory_inx;

                    if (directive == ".asciiz") {               // .ASCIIZ
                        size_t first = str.find_first_of('"') + 1;
                        size_t last = str.find_last_of('"') - 1;
                        size_t ascii_len = last - first + 1;
                        for (char c : str.substr(first, ascii_len)) {       // convert each char to ascii int
                            memory.push_back(std::to_string((int) c));
                            memory_inx = memory_inx + 4;
                        }
                        memory.push_back("0");                              // null terminator (asciiz convention)
                        memory_inx = memory_inx + 4;
                    } else {                                    // .WORD
                        memory.insert(memory.end(), terms.begin() + 1, terms.end());
                        memory_inx += (terms.end() - terms.begin() - 1)*4;
                    }
                }
            } else {                                            // Instruction
                size_t colon_pos = str.find(':');
                if (colon_pos != std::string::npos) {           // Find labels
                    instruction_label[str.substr(0, colon_pos)] = instruction_inx;
                } else {                                        // Add (non-label) instruction to instructions vector
                    instructions.push_back(str);
                    instruction_inx++;
                    
                    // Pseudo-instructions that expand to 2 instructions
                    std::string inst_type = split(str, WHITESPACE+",()")[0];
                    if (inst_type == "sge" || inst_type == "sle") {
                        instruction_inx++;
                    }
                }
            }
        }
        infile.close();

        // _END_OF_STATIC_MEMORY_
        memory_label["_END_OF_STATIC_MEMORY_"] = memory_inx;
        memory.push_back(std::to_string(memory_inx));

        
                    




    }      

    /** Phase 2
     * Process all static memory, output to static memory file
     */

    std::vector<double> memory_int;
    for (const auto& memory_line : memory) {                    // convert each memory entry to int
       if (isNumber(memory_line)) {
            memory_int.push_back(std::stoi(memory_line));
       } else {
            memory_int.push_back(instruction_label[memory_line]*4);
       }
    }  

    for (int entry : memory_int) {                              // write each entry to binary file
        write_binary(entry, static_outfile);
    }
    static_outfile.close();

    /** Phase 3
     * Process all instructions, output to instruction memory file
     */
    int pc = 0;

    for(std::string inst : instructions) {
        std::vector<std::string> terms = split(inst, WHITESPACE+",()");
        std::string inst_type = terms[0];
        // R-type: opcode(6) + rs(5) + rt(5) + rd(5) + shamt(5) + funct(6)
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
            // if only one register is given, default to $ra
            if (terms.size() == 2) {
                int result = encode_Rtype(0, registers[terms[1]], 0, 31, 0, 9);
                write_binary(result, inst_outfile);
            } else {
                // if two registers are given
                int result = encode_Rtype(0, registers[terms[1]], 0, registers[terms[2]], 0, 9);
                write_binary(result, inst_outfile);
            }
        }
        else if (inst_type == "mov") {
            // convert mov to add
            // move: mov $t0, $t1 --> add $t0, $t1, $zero
            int result = encode_Rtype(0, registers[terms[2]], 0, registers[terms[1]], 0, 32);
            write_binary(result, inst_outfile);
        }
        else if (inst_type == "syscall") {
            int result = encode_Rtype(0, 0, 0, 26, 0, 12);
            write_binary(result, inst_outfile);
        }
        else if (inst_type == "and") {
            int result = encode_Rtype(0,registers[terms[2]], registers[terms[3]], registers[terms[1]], 0, 36);
            write_binary(result, inst_outfile);
        }
        else if (inst_type == "or") {
            int result = encode_Rtype(0,registers[terms[2]], registers[terms[3]], registers[terms[1]], 0, 37);
            write_binary(result, inst_outfile);
        }
        else if (inst_type == "nor") {
            int result = encode_Rtype(0,registers[terms[2]], registers[terms[3]], registers[terms[1]], 0, 39);
            write_binary(result, inst_outfile);
        }
        else if (inst_type == "xor") {
            int result = encode_Rtype(0,registers[terms[2]], registers[terms[3]], registers[terms[1]], 0, 38);
            write_binary(result, inst_outfile);
        }
        // I-type: opcode(6) + rs(5) + rt(5) + immediate(16)
        else if (inst_type == "addi") {
            int result = encode_Itype(8, registers[terms[2]], registers[terms[1]], std::stoi(terms[3]));
            write_binary(result, inst_outfile);
        }
        else if (inst_type == "andi") {
            int result = encode_Itype(12, registers[terms[2]], registers[terms[1]], std::stoi(terms[3]));
            write_binary(result, inst_outfile);
        }
        else if (inst_type == "ori") {
            int result = encode_Itype(13, registers[terms[2]], registers[terms[1]], std::stoi(terms[3]));
            write_binary(result, inst_outfile);
        }
        else if (inst_type == "xori") {
            int result = encode_Itype(14, registers[terms[2]], registers[terms[1]], std::stoi(terms[3]));
            write_binary(result, inst_outfile);
        }
        else if (inst_type == "lui") {
            int result = encode_Itype(15, 0, registers[terms[1]], std::stoi(terms[2]));
            write_binary(result, inst_outfile);
        }
        else if (inst_type == "beq") {
            // when immediate is a number
            int offset;
            try {
                offset = std::stoi(terms[3]);
            }
            // when immediate is a label
            catch (const std::invalid_argument&) {
                offset = instruction_label[terms[3]] - (pc + 1);
            }
            int result = encode_Itype(4, registers[terms[1]], registers[terms[2]], offset);
            write_binary(result, inst_outfile);
        }
        else if (inst_type == "bne") {
            int offset;
            // when immediate is a number
            try {
                offset = std::stoi(terms[3]);
            }
            // when immediate is a label
            catch (const std::invalid_argument&) {  
                offset = instruction_label[terms[3]] - (pc + 1);
            }
            int result = encode_Itype(5, registers[terms[1]], registers[terms[2]], offset);
            write_binary(result, inst_outfile);
        }
        else if (inst_type == "lw") {
            int result = encode_Itype(35, registers[terms[3]], registers[terms[1]], std::stoi(terms[2]));
            write_binary(result, inst_outfile);
        }
        else if (inst_type == "sw") {
            int result = encode_Itype(43, registers[terms[3]], registers[terms[1]], std::stoi(terms[2]));
            write_binary(result, inst_outfile);
        }
        else if (inst_type == "la") {
            // convert la to addi
            // load address: la $t0, label --> addi $t0, $zero, label_address
            int label_address = memory_label[terms[2]];
            int result = encode_Itype(8, 0, registers[terms[1]], label_address);
            write_binary(result, inst_outfile);
        }
        else if (inst_type == "li") {
            // convert li to addi
            // load immediate: li $t0, 5 --> addi $t0, $zero, 5
            int result = encode_Itype(8, 0, registers[terms[1]], std::stoi(terms[2]));
            write_binary(result, inst_outfile);
        }
        // J-type: opcode(6) + target address(26)
        else if (inst_type == "j") {
            int target = instruction_label[terms[1]];
            int result = encode_Jtype(2, target);
            write_binary(result, inst_outfile);
        }
        else if (inst_type == "jal") {
            int target = instruction_label[terms[1]];
            int result = encode_Jtype(3, target);
            write_binary(result, inst_outfile);
        }
        // Pseudo-instructions
        else if (inst_type == "sge") {
            int slt = encode_Rtype(0, registers[terms[2]], registers[terms[3]], registers[terms[1]], 0, 42);
            write_binary(slt, inst_outfile);
            int xori = encode_Itype(14, registers[terms[1]], registers[terms[1]], 1); 
            write_binary(xori, inst_outfile);
            pc++;
        }
        else if (inst_type == "sle") {
            int slt = encode_Rtype(0, registers[terms[3]], registers[terms[2]], registers[terms[1]], 0, 42);
            write_binary(slt, inst_outfile);
            int xori = encode_Itype(14, registers[terms[1]], registers[terms[1]], 1); 
            write_binary(xori, inst_outfile);
            pc++;
        }
        else if (inst_type == "sgt") {
            int slt = encode_Rtype(0, registers[terms[3]], registers[terms[2]], registers[terms[1]], 0, 42);
            write_binary(slt, inst_outfile);
        }
        else {
            // exception handling for unknown instruction
            std::cerr<< "Unsupported instruction: " << inst_type << std::endl;
        }
        pc++;
    }
    inst_outfile.close();
}

#endif