using ZVSimulator

files = readdir(OUTDIR)

for file in files
  if ismatch(r"lqzv_(means|vars).txt$", file)
    writedlm_reformat(joinpath(OUTDIR, file), joinpath(OUTDIR, "pprint_"*file), fill("%.3e", 3))
  elseif ismatch(r"lqzv_vrfs.txt$", file)
    writedlm_reformat(joinpath(OUTDIR, file), joinpath(OUTDIR, "pprint_"*file), fill("%.2f", 2))
  end
end
