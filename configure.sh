#!/bin/bash

MAINPATH=`pwd`


for path in "application" "inclusion" "solver_ala_im_vs_expl" "king"
do
  cd $MAINPATH
  cd $path
  echo $path
  cmake . || exit 1
  make || exit 2
done
