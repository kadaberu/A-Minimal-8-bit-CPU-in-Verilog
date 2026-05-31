NVBOARD_HOME =  
include $(NVBOARD_HOME)/scripts/nvboard.mk

name=sCPU
objects_v=sCPU.v


objects_cpp=sCPU_sim.cpp
auto_pin_bind = sCPU_bind.cpp


sim:

	verilator --cc --exe --build --trace -j 0 -Wall $(objects_cpp) $(objects_v) $(auto_pin_bind) \
	$(NVBOARD_ARCHIVE) \
	-CFLAGS "-I/usr/include -I/usr/include/SDL2 -I$(NVBOARD_HOME)/usr/include" \
	-LDFLAGS "$(LDFLAGS)"
	./obj_dir/V$(name)


