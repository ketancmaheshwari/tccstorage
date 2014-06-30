#
# Two ways of generating a 2D heat map from ascii data
#
reset

set terminal pngcairo size 1000,800 enhanced font 'Verdana,12'
set output 'latheatmap.png'

set palette color positive
set samples 50; set isosamples 50
set tics norotate nooffset

#set title "Heat Map for intra-cloud latencies in msec"
set tic scale 0

# Color runs from white to green
#set palette rgbformula -7,2,-7
#set palette rgbformula 34,35,36
#set palette rgbformula 7,5,15
#set palette rgbformula 3,11,6
#set palette rgbformula 30,31,32
set palette rgbformula 33,13,10
#7,5,15   ... traditional pm3d (black-blue-red-yellow)
#3,11,6   ... green-red-violet
#23,28,3  ... ocean (green-blue-white); try also all other permutations
#21,22,23 ... hot (black-red-yellow-white)
#30,31,32 ... color printable on gray (black-blue-violet-yellow-white)
#33,13,10 ... rainbow (blue-green-yellow-red)
#34,35,36 ... AFM hot (black-red-yellow-white)
set cbrange [0:300]
set cblabel "Latency in msec"

set xrange [-0.5:160]
set yrange [-0.5:160]
#nv-nc-or-eu-sp-sd-sg-tk
set xlabel "US-east US-west-1 US-west-2       EU        SA          Aus        Singapore   Japan"
set ylabel "US-east US-west-1 US-west-2 EU   SA    Aus   Singapore   Japan"
#set ylabel "Virginia California Oregon Ireland Sao-Paulo Sydney Singapore Tokyo"
set view map
splot 'the_latmatrix.txt' matrix with image
