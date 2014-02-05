#!/bin/bash

# Call the script followed by a single argument, the number of workers

julia -p $1 -L example01_common_load.jl example01_driver_lqzv.jl
