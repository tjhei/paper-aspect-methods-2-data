#!/bin/bash

# global refinement:
for avg in "none" "arithmetic average" "geometric average" "harmonic average" "pick largest" "project to Q1"
do
	filename=`echo $avg Q2DGQ1 | sed 's/ /_/g'`
	echo "# DoFs L_2_error_velocity L_2_error_pressure" > $filename
	for r in "3" "4" "5" "6" "7" "8" "9" "10"
	do
	echo "ref $r:"
	cp global.prm.base temp.prm
	echo "subsection Mesh refinement" >>temp.prm
	echo "set Initial global refinement = $r" >> temp.prm
	echo "end" >> temp.prm
	echo "subsection Material model" >>temp.prm
	echo "set Material averaging = $avg" >> temp.prm
	echo "end" >> temp.prm
	echo "subsection Discretization" >>temp.prm
	echo "set Use locally conservative discretization = true" >>temp.prm
	echo "end" >> temp.prm
	./aspect temp.prm | gawk '/freedom/ {printf "%s ", $6}; /Error/ {print $8,$9}' | sed 's/,//g' >> $filename
	rm -f temp.prm
	done
done

