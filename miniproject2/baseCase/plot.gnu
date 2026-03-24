#!gnuplot
set terminal png size 800,600 enhanced #font "Helvetica, 14"
set grid

# 1) Plot solid Tmax and Tavg in time
set output "solid_Tmax_Tavg_time.png"
set title "Solid maximum and average temperature vs time"
set xlabel "t [s]"
set ylabel "T [K]"
set datafile commentschars "#"

FILE_MAX = "postProcessing/solid/solidTMinMax/0/fieldMinMax.dat"
FILE_AVG = "postProcessing/solid/solidTAvg/0/volFieldValue.dat"

TimeCol_max = 1
TmaxCol     = 8

TimeCol_avg = 1
TavgCol     = 2

plot \
    FILE_MAX using TimeCol_max:TmaxCol with lines lw 2 title "T_{max,solid}", \
    FILE_AVG using TimeCol_avg:TavgCol with lines lw 2 title "T_{avg,solid}"

unset output

# 2) Heat flux plot

FILE_BOTTOM    = "postProcessing/solid/bodyBottomQ/0/surfaceFieldValue.dat"
FILE_INTERFACE = "postProcessing/solid/solidInterfaceQ/0/surfaceFieldValue.dat"

set output "HeatFlux_Bottom.png
set title "Integrated heat flux of body bottom vs time"
set xlabel "t [s]"
set ylabel "Q [W]"
set grid
set datafile commentschars "#"

plot FILE_BOTTOM    using 1:2 with lines lw 2 title "Body bottom"
unset output

set output "HeatFlux_Interfaces.png
set title "Integrated heat flux of interfaces vs time"
set xlabel "t [s]"
set ylabel "Q [W]"
set grid
set datafile commentschars "#"

plot FILE_INTERFACE using 1:2 with lines lw 2 title "Solid-fluid interface"  
unset output

# Delta p versus T_max solid

FILE = "dp_Tmax.dat"

set output "dp_Tmax.png"

set title "Pressure drop vs maximum solid temperature"
set xlabel "dp [Pa]"
set ylabel "T_{max,solid} [K]"
set grid
set key off

plot FILE using 2:3 with lines lw 2

unset output

# Delta p in time

set output "dp.png"

set title "Pressure drop in time"
set xlabel "t [s]"
set ylabel "dp [Pa]"
set grid
set key off

plot FILE using 1:2 with lines lw 2

unset output

