#!gnuplot
set terminal png size 800,600 enhanced #font "Helvetica, 14"
set grid

set output "pressureDrop_allCases.png"
set title "Pressure drop history"
set xlabel "Iteration"
set ylabel "Delta p"

cases = "case0 case1 case2 case3 case4"

title_case(c) = \
    c eq "case0" ? "L = 0" : \
    c eq "case1" ? "L = 2" : \
    c eq "case2" ? "L = 4" : \
    c eq "case3" ? "L = 6" : \
    c eq "case4" ? "L = 8" : c

pInFile = "postProcessing/pInlet/0/surfaceFieldValue.dat"
pOutFile = "postProcessing/pOutlet/0/surfaceFieldValue.dat"

dp_cmd(case) = sprintf( \
    "< awk 'FNR==NR { if ($1 !~ /^#/) pin[$1]=$2; next } { if ($1 !~ /^#/) print $1, pin[$1]-$2 }' %s/%s %s/%s", case, pInFile, case, pOutFile)

plot for [i=1:words(cases)] \
    dp_cmd(word(cases, i)) title title_case(word(cases, i)) with lines lw 2
            
