#To be run as a gnuplot script as follows:

# $ gnuplot plotit.gp

set terminal pngcairo enhanced font 'Verdana,12'

set output "apptimesec2.png"
set xlabel "Application tasks"
set xrange[0:9000]
set yrange[23:85]
set ylabel "execution time in sec"
set grid
plot "ec2times.txt" u 1 w boxes lc rgb"#8b9dc3" notitle

set output "apptimes.png"
set yrange[11.5:12.6]
plot "apptimes.dat" u 1 w boxes lc rgb"grey" notitle
