@echo off
rem -----------------------------------------------------------------------------
rem  Title         : FPGA Build Script
rem -----------------------------------------------------------------------------
rem  File          : buildFpga.bat
rem  Author        : K.Deliparaschos (kdelip@mail.ntua.gr)
rem  Created       : 22/11/06
rem -----------------------------------------------------------------------------
rem  Description:
rem  Execute this script to build the FPGA. This script will execute
rem  Xilinx ISE for translate, map, place & route.
rem  Options for ISE are set at the top of this file.
rem
rem  Include the following optional suffixes, 0:no, 1:yes
rem  tran = 0|1, Execute translate step. (default) 
rem  map  = 0|1, Execute map step. (default) 
rem  par  = 0|1, Execute plac & route step. (default) 
rem  sim  = 0|1, Execute simulation model generation step.
rem  bit  = 0|1, Execute bit file generation step. (default)
rem  prom = 0|1, Execute prom file generation step. (default) 
rem 
rem  This script is called in the following manner:
rem  buildFpga.bat
rem  
rem -----------------------------------------------------------------------------
rem  Copyright (c) 2006 by K.Deliparaschos. All rights reserved.
rem -----------------------------------------------------------------------------
rem  Modification history:
rem  22/11/2006: created.
rem -----------------------------------------------------------------------------


rem ######### CONFIFURATION SECTION #########

rem Project name, used for input/output file names. 
rem $Project.edf must match the file name set for 
rem the output EDIF file in Synplicity Pro *.prj

set Project=ga_tsp
set EdfPath=../../syn/ga_tsp/rev_1/

rem #################
rem Translate Options
rem #################

rem UCF FIle
set UcfFile=%Project%.ucf

rem Set Target Device
set Target=xc3s1500-fg676-4

rem ###########
rem Map Options
rem ###########

rem Cover Mode: area, speed or balanced
set MapCover=speed

rem Pack FF Mode: i, o or b
set MapPack=b

rem Function Size: 4,5,6,7 or 8
set MapFunc=4

rem Pack Factor: 0 - 100
set MapFactor=100

rem Tristate Tranformation Mode: on, off, agressive or limit
set MapTristate=off

rem Effort Level: std, med or high
set MapEffort=high

rem Extra Effort Level for Timing-Driven-Packing
rem c: continue until timing contraints met
rem n: try alternative algorithms for timing
set ExtraEffort=c


rem #####################
rem Place & Route Options
rem #####################

rem Overall Place & Route Level: std, med, high
set ParLevel=high

rem Place & Route Start Table Entry
set ParTable=1

rem Number of Place & Route Iterations to run
set ParCount=1

rem Number of Place & Route Iterations to save
set ParSave=1

rem #####################
rem Timing report options
rem #####################

rem Timing Report Type: e or v (error or verbose)
set TwrType=v

rem Timing Report Error/Verbose Count
set TwrCount=10

rem Timing Report Limit
set TwrLimit=10

rem #############################
rem Gate Level Simulation Options
rem #############################

rem Speed grade for simulation model
set TimeSpeed=4

rem ############################
rem Prom File Generation Options
rem ############################

rem Prom Type For Generation
set PromType=xcf04s

rem #################
rem optional suffixes
rem #################

set  tran=1 
set  map=1
set  par=0
set  sim=0
set  bit=0
set  prom=0

rem ###### END CONFIFURATION SECTION ######


rem ###### PLACE % ROUTE ######


if %tran%==1 goto tran
if %tran%==0 goto mapif
if not %tran%==1 goto end
if not %tran%==0 goto end


:tran
echo ===== Starting Translate

ngdbuild.exe -p %Target% -sd /Cores -dd _ngo -nt timestamp -uc %Project%.ucf -intstyle ise %EdfPath%%Project%.edf %Project%.ngd 

echo ===== Translate Complete


:mapif
if %map%==1 goto map
if %map%==0 goto parif
if not %map%==1 goto end
if not %map%==0 goto end

:map
echo ===== Starting Map

rem Include for timing-driven-packing
rem -timing 
rem -xe %ExtraEffort%

map.exe -bp -intstyle ise -p %Target% -cm %MapCover% -detail -pr %MapPack% -k %MapFunc% -c %MapFactor% -tx %MapTristate% -ol %MapEffort% -o %Project%_map.ncd %Project%.ngd %Project%.pcf

echo ===== Map Complete

:parif
if %par%==1 goto par
if %par%==0 goto simif
if not %par%==1 goto end
if not %par%==0 goto end

:par
echo ===== Starting PandR

par.exe -w -intstyle ise -ol %ParLevel% -t %ParTable% -s %ParSave% -n %ParCount% %Project%_map.ncd %Project%.ncd %Project%.pcf

echo ===== PandR Complete


rem ###### END PLACE % ROUTE ######

:simif
if %sim%==1 goto sim
if %sim%==0 goto bitif
if not %sim%==1 goto end
if not %sim%==0 goto end

:sim
rem Do We Generate Simulation Model?

rem Generate sim filename
set simfile=%Project%_sim.vhd
set ngmfile=%Project%_map.ngm

rem Execute Command
echo ===== Starting Simulation Model

netgen.exe -intstyle ise -ofmt vhdl -sim -w -pcf %Project%.pcf -s %TimeSpeed% -xon true %Project%.ncd %simfile%

echo ===== Simulation Model Complete


:bitif
if %bit%==1 goto bit
if %bit%==0 goto promif
if not %bit%==1 goto end
if not %bit%==0 goto end

:bit
rem Do we generate bit file?
rem Execute Command

echo ===== Starting Bitgen

bitgen.exe -w -intstyle ise %Project%.ncd

echo ===== Bitgen Complete

:promif
if %prom%==1 goto prom
if %prom%==0 goto end
if not %prom%==1 goto end
if not %prom%==0 goto end

:prom
rem Do we generate prom file?

echo ===== Starting Prom Gen

promgen.exe -w -p mcs -c FF -u 0 %Project%.bit -x %PromType%

echo ===== Prom Gen Complete

:end