#!/bin/bash

# Call the script followed by a single argument, the number of workers

julia -p $1 -L example02_common_load.jl example02_driver_lqzv.jl
