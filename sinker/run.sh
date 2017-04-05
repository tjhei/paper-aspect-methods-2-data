#!/bin/bash

# note: this needs https://github.com/tjhei/looper installed

looper $ASPECT_DIR/aspect iters.prm | tee iters.log
looper $ASPECT_DIR/aspect iter_dgp1.prm | tee iter_dgp1.log
