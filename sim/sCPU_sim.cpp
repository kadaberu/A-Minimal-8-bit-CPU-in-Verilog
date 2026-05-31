#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include "verilated.h"
#include "VsCPU.h"
#include <nvboard.h>
void nvboard_bind_all_pins(VsCPU*);
static VerilatedContext* contextp;  
static VsCPU* top;                  
  int main(int argc, char** argv) {
       contextp = new VerilatedContext;
contextp->commandArgs(argc, argv);
      top = new VsCPU{contextp};
      int count=0;
      nvboard_bind_all_pins(top);
nvboard_init();
while (!contextp->gotFinish()) {
      nvboard_update();
top->eval();
}
nvboard_quit();
return 0;
}