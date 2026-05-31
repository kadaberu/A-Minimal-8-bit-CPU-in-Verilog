NVBOARD_HOME = /home/rzj71/ysyx-workbench/nvboard
include $(NVBOARD_HOME)/scripts/nvboard.mk

name=sCPU
objects_v=sCPU.v


objects_cpp=sCPU_sim.cpp
auto_pin_bind = sCPU_bind.cpp


all:
	@echo "Write this Makefile by your self."

sim:
	$(call git_commit, "sim RTL") # DO NOT REMOVE THIS LINE!!!
	@echo "Write this Makefile by your self."
	
	
	
	verilator --cc --exe --build --trace -j 0 -Wall $(objects_cpp) $(objects_v) $(auto_pin_bind) \
	$(NVBOARD_ARCHIVE) \
	-CFLAGS "-I/usr/include -I/usr/include/SDL2 -I$(NVBOARD_HOME)/usr/include" \
	-LDFLAGS "$(LDFLAGS)"
	./obj_dir/V$(name)

wave:
	verilator --binary --trace --$(name)- module $(name) $(object_v)
	./obj_dir/$(name)
	gtkwave dump.vcd
