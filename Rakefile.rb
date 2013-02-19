outdir = "/tmp/d/out"
compiler = "#{ENV['HOME']}/.denv/versions/2.061/linux/bin64/dmd"
compiler = "dmd"

desc 'compile snappy_cmdline'
snappy = "#{outdir}/snappy_cmdline"
file snappy => ['snappy.d', 'snappy_cmdline.d'] do |t|
  sh "dmd -m64 #{t.prerequisites.join(' ')} ~/.homebrew/lib/libsnappy.a -L-lstdc++ -od#{outdir}/obj -of#{t.name}"
end
task :default => snappy
