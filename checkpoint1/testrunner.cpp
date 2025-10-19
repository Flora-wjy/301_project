#include <iostream>
#include <cstdlib>
#include <fstream>
#include <string>

// Compare two text files line by line
bool compareTextFiles(const std::string &file1, const std::string &file2) {
    std::ifstream f1(file1), f2(file2);
    if (!f1 || !f2) {
        std::cerr << "Error: could not open one of " << file1 << " or " << file2 << "\n";
        return false;
    }

    std::string line1, line2;
    int lineNum = 1;
    while (true) {
        bool eof1 = !std::getline(f1, line1);
        bool eof2 = !std::getline(f2, line2);

        if (eof1 && eof2) return true;  // both ended, files equal
        if (eof1 || eof2 || line1 != line2) {
            std::cerr << "Mismatch at line " << lineNum << ":\n"
                      << "  " << file1 << ": " << line1 << "\n"
                      << "  " << file2 << ": " << line2 << "\n";
            return false;
        }
        lineNum++;
    }
}

int main() {
    for (int i = 1; i <= 5; i++) {
        std::string num = std::to_string(i);

        std::string out_static = "Testcases/Outputs/test" + num + "_static.bin";
        std::string out_inst   = "Testcases/Outputs/test" + num + "_inst.bin";

        std::string gold_static = "Testcases/GoldBinaries/test" + num + "static.bin";
        std::string gold_inst   = "Testcases/GoldBinaries/test" + num + "inst.bin";

        std::string cmd;
        if (i == 5) {
            cmd = "./assemble Testcases/Assembly/test51.asm "
                  "Testcases/Assembly/test52.asm "
                  "Testcases/Assembly/test53.asm "
                  + out_static + " " + out_inst;
        } else {
            cmd = "./assemble Testcases/Assembly/test" + num + ".asm " +
                  out_static + " " + out_inst;
        }

        std::cout << "Running: " << cmd << "\n";
        int ret = system(cmd.c_str());
        if (ret != 0) {
            std::cerr << "❌ Test " << i << " assembler failed.\n";
            return 1;
        }

        // Convert both output and gold binaries to text using readbytes
        std::string out_static_txt = out_static + ".txt";
        std::string out_inst_txt   = out_inst   + ".txt";
        std::string gold_static_txt = gold_static + ".txt";
        std::string gold_inst_txt   = gold_inst   + ".txt";

        system(("./readbytes " + out_static + " > " + out_static_txt).c_str());
        system(("./readbytes " + out_inst   + " > " + out_inst_txt).c_str());
        system(("./readbytes " + gold_static + " > " + gold_static_txt).c_str());
        system(("./readbytes " + gold_inst   + " > " + gold_inst_txt).c_str());

        // Compare text outputs
        bool static_ok = compareTextFiles(out_static_txt, gold_static_txt);
        bool inst_ok   = compareTextFiles(out_inst_txt, gold_inst_txt);

        if (!static_ok) {
            std::cerr << "❌ Test " << i << " failed (static mismatch).\n";
            return 1;
        }
        if (!inst_ok) {
            std::cerr << "❌ Test " << i << " failed (inst mismatch).\n";
            return 1;
        }

        std::cout << "✅ Test " << i << " passed!\n";
    }

    std::cout << "🎉 All tests passed!\n";
    return 0;
}
