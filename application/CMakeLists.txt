CMAKE_MINIMUM_REQUIRED(VERSION 2.8.8)

FIND_PACKAGE(Aspect REQUIRED HINTS ${ASPECT_DIR} ../ ../../ $ENV{Aspect_DIR})
DEAL_II_INITIALIZE_CACHED_VARIABLES()

SET(TARGET "boundary_layers")
PROJECT(${TARGET})

ADD_LIBRARY(${TARGET} SHARED boundary_layers.cc boundary_layers.h)
ASPECT_SETUP_PLUGIN(${TARGET})

SET(TARGET "citcom_reference_comparison")
PROJECT(${TARGET})

ADD_LIBRARY(${TARGET} SHARED citcom_reference_comparison.cc
citcom_reference_comparison.h)
ASPECT_SETUP_PLUGIN(${TARGET})

