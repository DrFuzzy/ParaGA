set no_lines $1
set res $2

vsim work.coordinates_rom_p
#do ../sim/spram1_wave.do
#add wave sim:/spram1/*
add log -r /*

force addr 0  0 $res, 1 20 $res, 2 30 $res, 11 40 $res


run [expr ($no_lines-1)*10] $res