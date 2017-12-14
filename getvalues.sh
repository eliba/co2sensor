#!/bin/bash

rrdtool update sensordata.rrd N:"$(python test.py /dev/hidraw0 | sed -e 's/ \|\|\.//g')"

rrdtool graph \
        /var/www/html/graphics/co2.png \
        --slope-mode \
        -h 200 \
	-w 500 \
        -X 0 \
        --start N-7200 \
        --end N \
        --vertical-label "CO2 ppm" \
        DEF:co2=sensordata.rrd:co2:AVERAGE \
\
        "CDEF:co2_100000=co2,100000,LT,co2,100000,IF" "CDEF:co2_100000NoUnk=co2,UN,0,co2_100000,IF" "AREA:co2_100000NoUnk#000000" \
        "CDEF:co2_5000=co2,5000,LT,co2,5000,IF" "CDEF:co2_5000NoUnk=co2,UN,0,co2_5000,IF" "AREA:co2_5000NoUnk#CC3300" \
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
	VDEF:co2last=co2,LAST \
	GPRINT:co2max:"MAX\:%6.0lf ppm" \
	GPRINT:co2last:"\t\t\t\t\t\t  Current\: %6.0lf ppm\n" \
        GPRINT:co2min:"MIN\:%6.0lf ppm" \
	GPRINT:co2last:"\t\t\t\t\t\t  Date\: %a, %d.%m.%Y\n":strftime \
        GPRINT:co2avg:"AVG\:%6.0lf ppm"
#        HRULE:9000#F52887:"test"


rrdtool graph \
        /var/www/html/graphics/temperatur.png \
        --slope-mode \
        -h 200 \
	-w 500 \
        -X 0 \
        -u 40 \
        -l 0 \
        --start N-7200 \
        --end N \
        --vertical-label "°C" \
        DEF:tempRAW=/root/sensordata.rrd:temp:AVERAGE \
        CDEF:temp=tempRAW,10,/ \
\
        "CDEF:temp_300=temp,300,LT,temp,300,IF" "CDEF:temp_300NoUnk=temp,UN,0,temp_300,IF" "AREA:temp_300NoUnk#FF9400" \
        "CDEF:temp_30=temp,30,LT,temp,30,IF" "CDEF:temp_30NoUnk=temp,UN,0,temp_30,IF" "AREA:temp_30NoUnk#FF9400" \
        "CDEF:temp_28=temp,28,LT,temp,28,IF" "CDEF:temp_28NoUnk=temp,UN,0,temp_28,IF" "AREA:temp_28NoUnk#FFC800" \
        "CDEF:temp_26=temp,26,LT,temp,26,IF" "CDEF:temp_26NoUnk=temp,UN,0,temp_26,IF" "AREA:temp_26NoUnk#FFDC00" \
        "CDEF:temp_24=temp,24,LT,temp,24,IF" "CDEF:temp_24NoUnk=temp,UN,0,temp_24,IF" "AREA:temp_24NoUnk#CCCC66" \
        "CDEF:temp_22=temp,22,LT,temp,22,IF" "CDEF:temp_22NoUnk=temp,UN,0,temp_22,IF" "AREA:temp_22NoUnk#D7FF00" \
        "CDEF:temp_20=temp,20,LT,temp,20,IF" "CDEF:temp_20NoUnk=temp,UN,0,temp_20,IF" "AREA:temp_20NoUnk#AACC00" \
        "CDEF:temp_18=temp,18,LT,temp,18,IF" "CDEF:temp_18NoUnk=temp,UN,0,temp_18,IF" "AREA:temp_18NoUnk#99CC66" \
        "CDEF:temp_16=temp,16,LT,temp,16,IF" "CDEF:temp_16NoUnk=temp,UN,0,temp_16,IF" "AREA:temp_16NoUnk#66CC66" \
        "CDEF:temp_14=temp,14,LT,temp,14,IF" "CDEF:temp_14NoUnk=temp,UN,0,temp_14,IF" "AREA:temp_14NoUnk#55CC66" \
        "CDEF:temp_12=temp,12,LT,temp,12,IF" "CDEF:temp_12NoUnk=temp,UN,0,temp_12,IF" "AREA:temp_12NoUnk#33CC99" \
        "CDEF:temp_10=temp,10,LT,temp,10,IF" "CDEF:temp_10NoUnk=temp,UN,0,temp_10,IF" "AREA:temp_10NoUnk#00CCAA" \
        "CDEF:temp_8=temp,8,LT,temp,8,IF" "CDEF:temp_8NoUnk=temp,UN,0,temp_8,IF" "AREA:temp_8NoUnk#00CCCC" \
        "CDEF:temp_6=temp,6,LT,temp,6,IF" "CDEF:temp_6NoUnk=temp,UN,0,temp_6,IF" "AREA:temp_6NoUnk#00CCFF" \
\
        LINE1:temp#000000 \
\
        VDEF:tempmax=temp,MAXIMUM \
        VDEF:tempmin=temp,MINIMUM \
        VDEF:tempavg=temp,AVERAGE \
        VDEF:templast=temp,LAST \
        GPRINT:tempmax:"MAX\:%6.1lf °C" \
        GPRINT:templast:"\t\t\t\t\t\t  Current\: %6.1lf °C\n" \
        GPRINT:tempmin:"MIN\:%6.1lf °C" \
        GPRINT:templast:"\t\t\t\t\t\t  Date\: %a, %d.%m.%Y\n":strftime \
        GPRINT:tempavg:"AVG\:%6.1lf °C"
