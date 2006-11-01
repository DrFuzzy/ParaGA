onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /crossover_v2_tb/clk
add wave -noupdate -format Logic /crossover_v2_tb/rst_n
add wave -noupdate -format Logic /crossover_v2_tb/crossen
add wave -noupdate -format Literal /crossover_v2_tb/crosspoint1
add wave -noupdate -format Literal /crossover_v2_tb/crosspoint2
add wave -noupdate -format Literal /crossover_v2_tb/crossrate
add wave -noupdate -format Literal /crossover_v2_tb/crossmethod
add wave -noupdate -format Literal /crossover_v2_tb/rng1
add wave -noupdate -format Literal /crossover_v2_tb/rng
add wave -noupdate -format Literal /crossover_v2_tb/ingene1
add wave -noupdate -format Literal /crossover_v2_tb/ingene2
add wave -noupdate -format Logic /crossover_v2_tb/crossdone
add wave -noupdate -format Literal /crossover_v2_tb/crossoffspr1
add wave -noupdate -format Literal /crossover_v2_tb/crossoffspr2
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4829904 ps} 0}
configure wave -namecolwidth 199
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
update
WaveRestoreZoom {4698654 ps} {4961154 ps}
