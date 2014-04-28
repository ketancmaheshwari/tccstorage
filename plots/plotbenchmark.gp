#To be run as a gnuplot script as follows:

# $ gnuplot plotbenchmark.gp

set terminal pngcairo enhanced font 'Verdana,12'
set datafile separator "|"
#set output "seq-benchmark.png"
set key left top
set xlabel "Data size in MB"
set xrange [0:5.4]
set xtics ("50" 0, "100" 1, "200" 2, "500" 3, "750" 4, "1000" 5, " " 5.4)
set ylabel "bandwidth in MB/sec"
set grid

#plot "seq_writetimes.txt" u 2 w lp lw 2 lc rgb"blue" title "S3 write", "seq_writetimes.txt" u 2:3 w errorbars lw 2 lc rgb"blue" notitle, \
# "seq_readtimes.txt" u 2 w lp lw 2 lc rgb"green" title "S3 read", "seq_readtimes.txt" u 2:3 w errorbars lw 2 lc rgb"green" notitle, \
# "seq_writetimes.txt" u 4 w lp lw 2 lc rgb"red" title "Mosa write", "seq_writetimes.txt" u 4:5 w errorbars lw 2  lc rgb"red" notitle, \
# "seq_readtimes.txt" u 4 w lp lw 2 lc rgb"orange" title "Mosa read", "seq_readtimes.txt" u 4:5 w errorbars lw 2 lc rgb"orange" notitle, \
# "seq_writetimes.txt" u 6 w lp lw 2 lc rgb"purple" title "Chirp/Parrot write", "seq_writetimes.txt" u 6:7 w errorbars lw 2 lc rgb"purple"  notitle, \
# "seq_readtimes.txt" u 6 w lp lw 2 lc rgb"brown" title "Chirp/Parrot read", "seq_readtimes.txt" u 6:7 w errorbars lw 2 lc rgb"brown"  notitle

#set output "par-write-benchmark.png"
#plot "par_writetimes.txt" u 2 w lp lw 2 lc rgb"green" title "S3 write", "par_writetimes.txt" u 2:3 w errorbars lw 2  lc rgb"green" notitle, \
# "par_writetimes.txt" u 8 w lp lw 2 lc rgb"orange" title "chirp write", "par_writetimes.txt" u 8:9 w errorbars lw 2  lc rgb"orange" notitle, \
# "par_writetimes.txt" u 6 w lp lw 2 lc rgb"blue" title "HDFS write", "par_writetimes.txt" u 6:7 w errorbars lw 2  lc rgb"blue" notitle, \
# "par_writetimes.txt" u 10 w lp lw 2 lc rgb"black" title "S3 w/o fuse write", "par_writetimes.txt" u 10:11 w errorbars lw 2  lc rgb"black" notitle, \
# "par_writetimes.txt" u 4 w lp lw 2 lc rgb"red" title "Mosa write", "par_writetimes.txt" u 4:5 w errorbars lw 2  lc rgb"red" notitle    
#set output "par-read-benchmark.png"
#plot  "par_readtimes.txt" u 2 w lp lw 2 lc rgb"green" title "S3 read", "par_readtimes.txt" u 2:3 w errorbars lw 2 lc rgb"green" notitle, \
# "par_readtimes.txt" u 6 w lp lw 2 lc rgb"orange" title "chirp read", "par_readtimes.txt" u 6:7 w errorbars lw 2 lc rgb"orange" notitle, \
# "par_readtimes.txt" u 8 w lp lw 2 lc rgb"blue" title "HDFS read", "par_readtimes.txt" u 8:9 w errorbars lw 2 lc rgb"blue" notitle, \
# "par_readtimes.txt" u 10 w lp lw 2 lc rgb"black" title "S3 w/o fuse read", "par_readtimes.txt" u 10:11 w errorbars lw 2 lc rgb"black" notitle, \
# "par_readtimes.txt" u 4 w lp lw 2 lc rgb"red" title "Mosa read", "par_readtimes.txt" u 4:5 w errorbars lw 2  lc rgb"red" notitle
#
#set output "RAW-benchmark.png"
#plot "raw.txt" u 2 w lp lw 2 lc rgb"green" title "S3", "raw.txt" u 2:3 w errorbars lw 2  lc rgb"green" notitle, \
# "raw.txt" u 6 w lp lw 2 lc rgb"orange" title "chirp", "raw.txt" u 6:7 w errorbars lw 2  lc rgb"orange" notitle, \
# "raw.txt" u 8 w lp lw 2 lc rgb"blue" title "HDFS", "raw.txt" u 8:9 w errorbars lw 2  lc rgb"blue" notitle, \
# "raw.txt" u 10 w lp lw 2 lc rgb"black" title "S3 w/o fuse", "raw.txt" u 10:11 w errorbars lw 2  lc rgb"black" notitle, \
# "raw.txt" u 4 w lp lw 2 lc rgb"red" title "Mosa", "raw.txt" u 4:5 w errorbars lw 2 lc rgb"red" notitle
#

#set output "par-write-bw.png"
#plot "par_writebw.txt" u 2 w lp lw 2 lc rgb"green" title "S3 write", "par_writebw.txt" u 2:3 w errorbars lw 2  lc rgb"green" notitle, \
# "par_writebw.txt" u 8 w lp lw 2 lc rgb"orange" title "chirp write", "par_writebw.txt" u 8:9 w errorbars lw 2  lc rgb"orange" notitle, \
# "par_writebw.txt" u 6 w lp lw 2 lc rgb"blue" title "HDFS write", "par_writebw.txt" u 6:7 w errorbars lw 2  lc rgb"blue" notitle, \
# "par_writebw.txt" u 10 w lp lw 2 lc rgb"black" title "S3 w/o fuse write", "par_writebw.txt" u 10:11 w errorbars lw 2  lc rgb"black" notitle, \
# "par_writebw.txt" u 4 w lp lw 2 lc rgb"red" title "Mosa write", "par_writebw.txt" u 4:5 w errorbars lw 2  lc rgb"red" notitle    
#
#set output "par-read-bw.png"
#plot  "par_readbw.txt" u 2 w lp lw 2 lc rgb"green" title "S3 read", "par_readbw.txt" u 2:3 w errorbars lw 2 lc rgb"green" notitle, \
# "par_readbw.txt" u 6 w lp lw 2 lc rgb"orange" title "chirp read", "par_readbw.txt" u 6:7 w errorbars lw 2 lc rgb"orange" notitle, \
# "par_readbw.txt" u 8 w lp lw 2 lc rgb"blue" title "HDFS read", "par_readbw.txt" u 8:9 w errorbars lw 2 lc rgb"blue" notitle, \
# "par_readbw.txt" u 10 w lp lw 2 lc rgb"black" title "S3 w/o fuse read", "par_readbw.txt" u 10:11 w errorbars lw 2 lc rgb"black" notitle, \
# "par_readbw.txt" u 4 w lp lw 2 lc rgb"red" title "Mosa read", "par_readbw.txt" u 4:5 w errorbars lw 2  lc rgb"red" notitle
#
#set output "RAW-bw.png"
#plot "par_rawbw.txt" u 2 w lp lw 2 lc rgb"green" title "S3", "par_rawbw.txt" u 2:3 w errorbars lw 2  lc rgb"green" notitle, \
# "par_rawbw.txt" u 6 w lp lw 2 lc rgb"orange" title "chirp", "par_rawbw.txt" u 6:7 w errorbars lw 2  lc rgb"orange" notitle, \
# "par_rawbw.txt" u 8 w lp lw 2 lc rgb"blue" title "HDFS", "par_rawbw.txt" u 8:9 w errorbars lw 2  lc rgb"blue" notitle, \
# "par_rawbw.txt" u 10 w lp lw 2 lc rgb"black" title "S3 w/o fuse", "par_rawbw.txt" u 10:11 w errorbars lw 2  lc rgb"black" notitle, \
# "par_rawbw.txt" u 4 w lp lw 2 lc rgb"red" title "Mosa", "par_rawbw.txt" u 4:5 w errorbars lw 2 lc rgb"red" notitle

set output "par-write-bw.png"
plot "par_writebw.txt" u 2 w lp lw 2 lc rgb"green" title "S3 write", \
 "par_writebw.txt" u 8 w lp lw 2 lc rgb"orange" title "chirp write",  \
 "par_writebw.txt" u 6 w lp lw 2 lc rgb"blue" title "HDFS write", \
 "par_writebw.txt" u 10 w lp lw 2 lc rgb"black" title "S3 w/o fuse write", \
 "par_writebw.txt" u 4 w lp lw 2 lc rgb"red" title "Mosa write"

set output "par-read-bw.png"
plot  "par_readbw.txt" u 2 w lp lw 2 lc rgb"green" title "S3 read", \
 "par_readbw.txt" u 6 w lp lw 2 lc rgb"orange" title "chirp read", \
 "par_readbw.txt" u 8 w lp lw 2 lc rgb"blue" title "HDFS read", \
 "par_readbw.txt" u 10 w lp lw 2 lc rgb"black" title "S3 w/o fuse read", \
 "par_readbw.txt" u 4 w lp lw 2 lc rgb"red" title "Mosa read"

set output "RAW-bw.png"
plot "par_rawbw.txt" u 2 w lp lw 2 lc rgb"green" title "S3", \
 "par_rawbw.txt" u 6 w lp lw 2 lc rgb"orange" title "chirp", \
 "par_rawbw.txt" u 8 w lp lw 2 lc rgb"blue" title "HDFS", \
 "par_rawbw.txt" u 10 w lp lw 2 lc rgb"black" title "S3 w/o fuse", \
 "par_rawbw.txt" u 4 w lp lw 2 lc rgb"red" title "Mosa"


