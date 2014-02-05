common_srcfiles = ["covariance_matrices.jl"]

for file in common_srcfiles
  include(joinpath(dirname(@__FILE__), file))
end
