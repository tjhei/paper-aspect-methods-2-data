# paper-aspect-methods-2-data

This repository accompanies the paper

    High Accuracy Mantle Convection Simulation through Modern Numerical Methods II:
    Realistic Models and Problems
    by T. Heister, J. Dannberg, R. Gassmöller, W. Bangerth
    
and contains data files and code to reproduce the computations of the paper.


Contents
--------

``aspect/`` - the version of ASPECT used in the paper (v.1.5.0, git submodule, so you might need to run ``git submodule init && git submodule update`` if you did not clone this repository with ``--recursive``.

``solver_ala_im_vs_expl/`` - solver comparison for implicit vs explicit compressible ALA (Table 1)

``tangurnis/`` - TanGurnis compressible Stokes benchmark, see ASPECT (Table 2)

``king/`` - King2010 benchmark (Table 4 and Appendix)

``sinker/`` - Sinker problem, averaging of properties (Figure 2 and 4, Table 5)

``inclusion/`` - Inclusion benchmark with reference solution (Figure 3 and 5)

``latent-heat/`` - Latent heat benchmark (Figure 7)

``global-adaptive-refinement/`` - Global 2d convection and adaptive mesh refinement (Figure 8)

``finite_strain/`` - Tracking finite strain example (Figure 9)

``application/`` - Global, 3d mantle convection example (Figure 10)


Instructions
------------

install ASPECT:
```
export DEAL_II_DIR=/ssd/deal-releases/dealii-8.4.2/installed/
export ASPECT_DIR=`pwd`/aspect
git submodule init
git submodule update
cd aspect && cmake -D CMAKE_BUILD_TYPE=Release . && make -j 8
```

compile plugins (with ``ASPECT_DIR`` set):
```
./configure.sh
```
