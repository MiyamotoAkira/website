task :build do
  sh 'bundle exec jekyll build --config _config.yml --trace'
end

task :serve do
  sh 'bundle exec jekyll serve --config _config.yml --watch --trace --port 4000 --host 0.0.0.0'
end

task :servequick do
  sh 'bundle exec jekyll serve --config _config.yml --watch --trace --limit_posts 3 --port 40000 --host 0.0.0.0'
end


require 'net/ssh'

$user = "akira"
$host = "twoormore.eu"
$destination = "#{$user}@#{$host}"
$folder = "/var/www/TwoOrMore"
$releases = "/releases"
$current = "/current"
$time = Time.new.strftime("%Y%m%d%H%M%S")

desc "Build the jekyll site"
task :build_jekyll do
    sh "jekyll build"
end

desc "Delete the _site folder"
task :clean_build do
  if Dir.exists?("_site")
    sh "rm -r _site"
  end
end

$folderdestination = "#{$folder}#{$releases}/#{$time}"
$fulldestination = "#{$destination}:#{$folderdestination}"
$symlink = "#{$folder}#{$current}"


desc "create target folder"
task :create_folder do
  Net::SSH.start($host, $user) do |ssh|
    ssh.exec!("mkdir #{$fulldestination}")
  end
end

desc "transfer files"
task :transfer_files do
  sh "scp -r  _site/. #{$fulldestination}"
end

desc "remove previous symlink"
task :remove_symlink do
  Net::SSH.start($host, $user) do |ssh|
    ssh.exec!("rm -r #{$symlink}")
  end
end

desc "create symbolic link"
task :create_symlink do
  Net::SSH.start($host, $user) do |ssh|
    ssh.exec!("ln -s #{$folderdestination} #{$symlink}")
  end
end

task :deploy => [:clean_build, :build_jekyll, :create_folder, :transfer_files, :remove_symlink, :create_symlink]
