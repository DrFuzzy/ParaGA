onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /selection_v2/clk
add wave -noupdate -format Logic /selection_v2/rst_n
add wave -noupdate -format Literal /selection_v2/ingene
add wave -noupdate -format Literal /selection_v2/rng
add wave -noupdate -format Literal /selection_v2/fitsum
add wave -noupdate -format Logic /selection_v2/data_valid
add wave -noupdate -format Literal /selection_v2/selparent
add wave -noupdate -format Logic /selection_v2/rd
add wave -noupdate -format Literal -radix unsigned /selection_v2/selout
add wave -noupdate -format Logic /selection_v2/done
add wave -noupdate -format Logic /selection_v2/done_t
add wave -noupdate -format Literal -radix unsigned /selection_v2/cumsum_p1
add wave -noupdate -format Literal -radix unsigned /selection_v2/scalfitsum
add wave -noupdate -format Literal /selection_v2/scalfitsum_p
add wave -noupdate -format Literal /selection_v2/count
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {10 ns} 0}
configure wave -namecolwidth 219
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
WaveRestoreZoom {0 ns} {141 ns}
