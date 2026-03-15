#!gnuplot
set terminal png size 800,600 enhanced #font "Helvetica, 14"
set grid

# 1) Residuals plot
set output 'Residuals.png'
set logscale y
set title "Residuals"
set ylabel 'Residual'
set format y "%2.1e";
set xlabel 'Iteration'

logFile="LOG.simpleFoam"

plot "< cat ".logFile." | grep 'Solving for Ux' | cut -d' ' -f9 | tr -d ','" title 'Ux' with lines,\
	"< cat ".logFile." | grep 'Solving for Uy' | cut -d' ' -f9 | tr -d ','" title 'Uy' with lines,\
	"< cat ".logFile." | grep 'Solving for omega' | cut -d' ' -f9 | tr -d ','" title 'omega' with lines,\
	"< cat ".logFile." | grep 'Solving for k' | cut -d' ' -f9 | tr -d ','" title 'k' with lines,\
	"< cat ".logFile." | grep 'Solving for p,' | awk 'NR%3==0 {gsub(\",\",\"\",$8); print $8}'" title 'p' with lines

unset output

# 2) Pressure-drop plot
unset logscale y
set output "pressureDrop.png"
set title "Pressure drop history"
set xlabel "Iteration"
set ylabel "Delta p"

pInFile = "postProcessing/pInlet/0/surfaceFieldValue.dat"
pOutFile = "postProcessing/pOutlet/0/surfaceFieldValue.dat"

plot "< awk ' \
FNR==NR { \
    if ($1 !~ /^#/) pin[$1]=$2; \
    next \
} \
{ \
    if ($1 !~ /^#/ && ($1 in pin)) print $1, pin[$1]-$2 \
}' ".pInFile." ".pOutFile \
title 'Pressure drop' with lines

unset output
