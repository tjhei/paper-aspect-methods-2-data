#!/bin/bash

for case in "implicit" "explicit"
do
  for c in "0" "1" "10" "30"
  do
    for ref in "5" "6" "7" "8"
    do
      echo "$case-c$c-ref$ref:"
      cp $case.prm temp.prm
      echo "subsection Mesh refinement" >> temp.prm
      echo "  set Initial global refinement = $ref" >> temp.prm
      echo "end" >> temp.prm
      echo "subsection Adiabatic conditions model" >> temp.prm
      echo "  subsection Function" >> temp.prm
      echo "    set Function constants  = c=$c" >> temp.prm
      echo "  end" >> temp.prm
      echo "end" >> temp.prm

      # note: the head command removes the last iterative solve, because
      # ASPECT will always do a final solve even if the nonlinear system has
      # already converged:
      mpirun -n 4 $ASPECT_DIR/aspect temp.prm | grep "Solving" | head -n -1 | tee output.log
    done
  done
done

rm -f temp.prm
