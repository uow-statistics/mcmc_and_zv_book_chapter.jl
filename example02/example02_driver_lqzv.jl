@everywhere using Distributions, MCMC, ZVSimulator

@everywhere nextidx(i) = (idx=i; idx+=1; idx)

@everywhere df = [5., 10., 25., 50., 100., fill(25., 7)]
@everywhere npars = [fill(2, 5), 3, 5, 10, fill(5, 4)]
@everywhere a = [fill(0., 8), 0.25, 0.5, 0.75, 0.99]

@everywhere idx = 1
while idx <= length(df)
  @everywhere c = ((df[idx]-2)/df[idx])*C(npars[idx], a[idx])
  @everywhere mcmodel = model(MvTDist(df[idx], zeros(npars[idx]), c), init=zeros(npars[idx]))
  @everywhere samplers = [HMCDA() for i in 1:1000]
  @everywhere tasks = mcmodel * samplers * SerialMC(steps=101000, burnin=1000)

  results = psim_serialmc_vrf(tasks)

  outfile = joinpath(OUTDIR, "example02_hmcda")
  outfile *= "_df"*@sprintf("%03d", df[idx])
  outfile *= "_n"*@sprintf("%03d", npars[idx]) 
  outfile *= "_a"*@sprintf("%.3f", a[idx])*"_lqzv"
  writedlm_vrf(results, outfile, ' ')

  @everywhere idx = nextidx(idx)
end
