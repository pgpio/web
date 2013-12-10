require 'bundler/setup'

# Bring in all tasks defined in .rake files in lib/tasks
Dir.glob('lib/tasks/*.rake').each do |f|
  import f
end

# For Travis.ci, default task runs tests
task :default => :test

desc "Run a local server."
task :local do
  Kernel.exec("shotgun -s thin -p 9393")
end
