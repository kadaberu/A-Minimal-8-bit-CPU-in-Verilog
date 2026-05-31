#include <nvboard.h>
#include "VsCPU.h"

void nvboard_bind_all_pins(VsCPU*top ) {

	nvboard_bind_pin(&top->clk, 1, BTNC);
    nvboard_bind_pin(&top->reset, 1, SW0);
	nvboard_bind_pin(&top->led1, 7, SEG0G, SEG0F, SEG0E, SEG0D, SEG0C, SEG0B, SEG0A);
    nvboard_bind_pin(&top->led2, 7, SEG1G, SEG1F, SEG1E, SEG1D, SEG1C, SEG1B, SEG1A);
     nvboard_bind_pin(&top->dbg_pc, 5, LD4, LD3, LD2, LD1, LD0);

}