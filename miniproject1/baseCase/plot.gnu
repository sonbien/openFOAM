#!gnuplot
set terminal png size 800,600 enhanced #font "Helvetica, 14"
set grid

# 1) Residuals plot
set output 'Residuals.png'
set logscale y
set title "Initial Residuals"
set ylabel 'Residual'
set format y "%2.1e";
set xlabel 'Iteration'
set datafile commentschars "#"

resFile="postProcessing/solverInfo1/0/solverInfo.dat"

plot \
    resFile using 1:3  with lines lw 2 title 'Ux', \
    ''                   using 1:6  with lines lw 2 title 'Uy', \
    ''                   using 1:9  with lines lw 2 title 'Uz', \
    ''                   using 1:14 with lines lw 2 title 'k',  \
    ''                   using 1:19 with lines lw 2 title 'omega', \
    ''                   using 1:24 with lines lw 2 title 'p'
unset output

# 2) Cd plot
unset logscale y
set output 'Cd.png'
set grid
set xlabel 'Iteration'
set ylabel 'Cd'
set title 'Drag coefficient'

cdFile="postProcessing/forceCoeffs/0/coefficient.dat"

plot cdFile using 1:2 with lines lw 2 title 'Cd'
unset output

# 3) Cd components
unset logscale y
set output 'dragForces.png'
set grid
set xlabel 'Iteration'
set ylabel 'Percent of total drag [%]'
set title 'Drag percentage'

File = "postProcessing/forces/0/forces_clean.dat"

plot \
    File using 1:(abs($2)>1e-12 ? 100.0*abs($5)/abs($2) : 1/0) with lines lw 2 title 'pressure %', \
    ''   using 1:(abs($2)>1e-12 ? 100.0*abs($8)/abs($2) : 1/0) with lines lw 2 title 'viscous %', \
    ''   using 1:(abs($2)>1e-12 ? 100.0*abs($2)/abs($2) : 1/0) with lines lw 2 title 'total %'
