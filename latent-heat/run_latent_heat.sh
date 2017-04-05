#!/bin/bash

# global refinement:
for width in "1000" "2000" "4000" "8000" "16000" "32000"
do
	filename=`echo $width | sed 's/ /_/g'`
	echo "writing $filename..."
	rm $filename
	echo "# DoFs averageT" >> $filename
	for r in "25" "50" "100" "200" "400" "800" "1600"
	do
	echo "refinement $r:"
	cp global.prm.base temp.prm
        x_extent=`echo "scale=10; 2000000/$r" | bc`
	echo "subsection Geometry model" >>temp.prm
	echo "subsection Box" >>temp.prm
	echo "set X extent = $x_extent" >> temp.prm
	echo "set Y repetitions = $r" >> temp.prm
	echo "end" >> temp.prm
	echo "end" >> temp.prm
	echo "subsection Material model" >>temp.prm
	echo "subsection Latent heat" >>temp.prm
	echo "set Phase transition widths = $width" >> temp.prm
	echo "end" >> temp.prm
	echo "end" >> temp.prm
	$ASPECT_DIR/aspect temp.prm | gawk '/freedom/ {printf "%s ", $6}' | sed 's/,//g' >> $filename
        T_max=`grep "Maximal temperature (K)" output/statistics | gawk '{ print $2}' | sed s/.$//`
        tail -1 output/statistics | gawk "{ print \$${T_max}}" | tee -a $filename
	grep Solving output/log.txt
	rm -f temp.prm
	done
done

