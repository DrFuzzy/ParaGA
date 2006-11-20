# Synplicity, Inc. constraint file
# D:\Designs\GA_eval\syn\GA_TSP\ga_tsp.sdc
# Written on Wed Nov 15 19:25:42 2006
# by Synplify Pro, Synplify Pro 8.5.1 Scope Editor

#
# Collections
#

#
# Clocks
#
define_clock            -name {clk}  -freq 100.000 -clockgroup default_clkgroup_0

#
# Clock to Clock
#

#
# Inputs/Outputs
#
define_input_delay -disable      -default -improve 0.00 -route 0.00
define_output_delay -disable     -default -improve 0.00 -route 0.00
define_output_delay -disable     {best_fit[15:0]} -improve 0.00 -route 0.00
define_output_delay -disable     {best_gene[20:0]} -improve 0.00 -route 0.00
define_output_delay -disable     {ga_fin} -improve 0.00 -route 0.00
define_input_delay -disable      {rst_n} -improve 0.00 -route 0.00
define_input_delay -disable      {run_ga_i} -improve 0.00 -route 0.00
define_input_delay -disable      {seed_1_i[7:0]} -improve 0.00 -route 0.00
define_input_delay -disable      {seed_2_i[5:0]} -improve 0.00 -route 0.00
define_input_delay -disable      {seed_3_i[3:0]} -improve 0.00 -route 0.00

#
# Registers
#

#
# Multicycle Path
#

#
# False Path
#

#
# Path Delay
#

#
# Attributes
#
define_global_attribute          syn_netlist_hierarchy {1}
define_global_attribute          syn_useioff {1}
define_global_attribute          syn_romstyle {block_rom}
define_global_attribute -disable syn_ramstyle {registers}

#
# I/O standards
#

#
# Compile Points
#

#
# Other Constraints
#
