onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /control2/clk
add wave -noupdate -format Logic /control2/cross_in
add wave -noupdate -format Logic /control2/done
add wave -noupdate -format Logic /control2/fill_ram
add wave -noupdate -format Logic /control2/fit_eval
add wave -noupdate -format Logic /control2/mut_in
add wave -noupdate -format Logic /control2/ram
add wave -noupdate -format Logic /control2/rd_in
add wave -noupdate -format Logic /control2/rst_n
add wave -noupdate -format Logic /control2/sel
add wave -noupdate -format Logic /control2/sort_in
add wave -noupdate -format Logic /control2/term_in
add wave -noupdate -format Logic /control2/wr
add wave -noupdate -format Logic /control2/clear
add wave -noupdate -format Logic /control2/cross_out
add wave -noupdate -format Logic /control2/eval
add wave -noupdate -format Logic /control2/fill
add wave -noupdate -format Logic /control2/idl
add wave -noupdate -format Logic /control2/init
add wave -noupdate -format Logic /control2/mut_out
add wave -noupdate -format Logic /control2/sel_out
add wave -noupdate -format Logic /control2/sort_out
add wave -noupdate -format Logic /control2/term_out
add wave -noupdate -format Logic /control2/we
add wave -noupdate -format Literal /control2/sreg
add wave -noupdate -format Literal /control2/next_sreg
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
WaveRestoreZoom {0 ns} {10645 ns}
