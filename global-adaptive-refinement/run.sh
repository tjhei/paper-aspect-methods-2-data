#!/bin/bash
NP=8

mpirun -n $NP $ASPECT_DIR/aspect global_model.prm

for path in "refinement_energy_density" "refinement_temperature" "refinement_viscosity"
do
  echo "$path:"
  mkdir -p $path
  rm -f $path/restart*
  for file in `ls output_energy_density/restart*`
  do
    ln -s `pwd`/$file $path/
  done

  mpirun -n $NP $ASPECT_DIR/aspect $path.prm
done
