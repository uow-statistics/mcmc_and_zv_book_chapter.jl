@everywhere using Distributions, MCMC, ZVSimulator

@everywhere nextidx(i) = (idx=i; idx+=1; idx)

@everywhere npars = [2, 3, 5, 10, fill(5, 4)]
@everywhere a = [fill(0., 4), 0.25, 0.5, 0.75, 0.99]

@everywhere idx = 1
while idx <= length(npars)
  @everywhere c = C(npars[idx], a[idx])
  @everywhere mcmodel = model(MvNormal(zeros(npars[idx]), c), init=zeros(npars[idx]))
  @everywhere samplers = [HMCDA() for i in 1:1000]
  @everywhere tasks = mcmodel * samplers * SerialMC(steps=101000, burnin=1000)

  results = psim_serialmc_vrf(tasks)

  outfile = joinpath(OUTDIR, "example02_hmcda")
  outfile *= "_n"*@sprintf("%03d", npars[idx]) 
  outfile *= "_a"*@sprintf("%.3f", a[idx])*"_lqzv"
  writedlm_vrf(results, outfile, ' ')

  @everywhere idx = nextidx(idx)
end
