#!/bin/bash

# draw the last 24 hours

function drawday()
{
	rrdtool graph \
        /var/www/html/graphics/today-$1.png \
        --slope-mode \
        -h 200 \
        -w 1000 \
        -X 0 \
        --start N-$1 \
        --end N-$2 \
        --vertical-label "CO2 ppm" \
        DEF:co2=/root/sensordata.rrd:co2:AVERAGE \
	DEF:tempRAW=/root/sensordata.rrd:temp:AVERAGE \
	CDEF:temp=tempRAW,10,/ \
\
        "CDEF:co2_80000=co2,80000,LT,co2,80000,IF" "CDEF:co2_80000NoUnk=co2,UN,0,co2_80000,IF" "AREA:co2_80000NoUnk#CC0000" \
        "CDEF:co2_2500=co2,2500,LT,co2,2500,IF" "CDEF:co2_2500NoUnk=co2,UN,0,co2_2500,IF" "AREA:co2_2500NoUnk#ff0000" \
        "CDEF:co2_1900=co2,1900,LT,co2,1900,IF" "CDEF:co2_1900NoUnk=co2,UN,0,co2_1900,IF" "AREA:co2_1900NoUnk#ff0400" \
        "CDEF:co2_1800=co2,1800,LT,co2,1800,IF" "CDEF:co2_1800NoUnk=co2,UN,0,co2_1800,IF" "AREA:co2_1800NoUnk#ff0800" \
        "CDEF:co2_1700=co2,1700,LT,co2,1700,IF" "CDEF:co2_1700NoUnk=co2,UN,0,co2_1700,IF" "AREA:co2_1700NoUnk#ff3300" \
        "CDEF:co2_1600=co2,1600,LT,co2,1600,IF" "CDEF:co2_1600NoUnk=co2,UN,0,co2_1600,IF" "AREA:co2_1600NoUnk#ff5300" \
        "CDEF:co2_1500=co2,1500,LT,co2,1500,IF" "CDEF:co2_1500NoUnk=co2,UN,0,co2_1500,IF" "AREA:co2_1500NoUnk#ff7200" \
        "CDEF:co2_1400=co2,1400,LT,co2,1400,IF" "CDEF:co2_1400NoUnk=co2,UN,0,co2_1400,IF" "AREA:co2_1400NoUnk#ff8200" \
        "CDEF:co2_1300=co2,1300,LT,co2,1300,IF" "CDEF:co2_1300NoUnk=co2,UN,0,co2_1300,IF" "AREA:co2_1300NoUnk#ff9400" \
        "CDEF:co2_1200=co2,1200,LT,co2,1200,IF" "CDEF:co2_1200NoUnk=co2,UN,0,co2_1200,IF" "AREA:co2_1200NoUnk#ffb800" \
        "CDEF:co2_1100=co2,1100,LT,co2,1100,IF" "CDEF:co2_1100NoUnk=co2,UN,0,co2_1100,IF" "AREA:co2_1100NoUnk#ffc400" \
        "CDEF:co2_1000=co2,1000,LT,co2,1000,IF" "CDEF:co2_1000NoUnk=co2,UN,0,co2_1000,IF" "AREA:co2_1000NoUnk#ffc800" \
        "CDEF:co2_900=co2,900,LT,co2,900,IF" "CDEF:co2_900NoUnk=co2,UN,0,co2_900,IF" "AREA:co2_900NoUnk#ffdc00" \
        "CDEF:co2_800=co2,800,LT,co2,800,IF" "CDEF:co2_800NoUnk=co2,UN,0,co2_800,IF" "AREA:co2_800NoUnk#fffa00" \
        "CDEF:co2_700=co2,700,LT,co2,700,IF" "CDEF:co2_700NoUnk=co2,UN,0,co2_700,IF" "AREA:co2_700NoUnk#d7ff00" \
        "CDEF:co2_600=co2,600,LT,co2,600,IF" "CDEF:co2_600NoUnk=co2,UN,0,co2_600,IF" "AREA:co2_600NoUnk#8aff00" \
        "CDEF:co2_500=co2,500,LT,co2,500,IF" "CDEF:co2_500NoUnk=co2,UN,0,co2_500,IF" "AREA:co2_500NoUnk#00ff10" \
        "CDEF:co2_400=co2,400,LT,co2,400,IF" "CDEF:co2_400NoUnk=co2,UN,0,co2_400,IF" "AREA:co2_400NoUnk#00ff5c" \
\
        LINE1:co2#000000 \
        -u 2000 \
        -l 0 \
\
        VDEF:co2max=co2,MAXIMUM \
        VDEF:co2min=co2,MINIMUM \
        VDEF:co2avg=co2,AVERAGE \
	VDEF:tempmax=temp,MAXIMUM \
	VDEF:tempmin=temp,MINIMUM \
	VDEF:tempavg=temp,AVERAGE \
        VDEF:date=co2,LAST \
\
	GPRINT:date:"%a, %d.%m.%Y":strftime \
        GPRINT:co2max:"\tCO2 Day-MAX\:%6.0lf ppm" \
        GPRINT:tempmax:"\t\tTemp Day-MAX\:%6.1lf °C\n" \
        GPRINT:date::strftime \
        GPRINT:co2min:"\t\t\t\tCO2 Day-MIN\:%6.0lf ppm" \
        GPRINT:tempmin:"\t\tTemp Day-MIN\:%6.1lf °C\n" \
        GPRINT:date::strftime \
        GPRINT:co2avg:"\t\t\t\tCO2 Day-AVG\:%6.0lf ppm" \
        GPRINT:tempavg:"\t\tTemp Day-AVG\:%6.1lf °C\n"
}

seconds=604800

while [ $seconds -gt 0 ] ; do
	start=$((seconds-1))
	end=$((start-86399))
	drawday $start $end
	seconds=$(($seconds-86400))
done
