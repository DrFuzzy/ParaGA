onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /control/clk
add wave -noupdate -format Logic /control/cross_in
add wave -noupdate -format Logic /control/done
add wave -noupdate -format Logic /control/fill_ram
add wave -noupdate -format Logic /control/fit_eval
add wave -noupdate -format Logic /control/mut_in
add wave -noupdate -format Logic /control/ram
add wave -noupdate -format Logic /control/rst_n
add wave -noupdate -format Logic /control/sel
add wave -noupdate -format Logic /control/sort_in
add wave -noupdate -format Logic /control/term_in
add wave -noupdate -format Logic /control/wr
add wave -noupdate -format Logic /control/clear
add wave -noupdate -format Logic /control/cross_out
add wave -noupdate -format Logic /control/eval
add wave -noupdate -format Logic /control/fill
add wave -noupdate -format Logic /control/init
add wave -noupdate -format Logic /control/mut_out
add wave -noupdate -format Logic /control/sel_out
add wave -noupdate -format Logic /control/sort_out
add wave -noupdate -format Logic /control/term_out
add wave -noupdate -format Logic /control/we
add wave -noupdate -format Literal /control/sreg
add wave -noupdate -format Literal /control/next_sreg
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
configure wave -namecolwidth 150
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
WaveRestoreZoom {0 ns} {10761 ns}
