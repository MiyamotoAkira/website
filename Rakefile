task :build do
  sh 'bundle exec jekyll build --config _config.yml --trace'
end

task :serve do
  sh 'bundle exec jekyll serve --config _config.yml --watch --trace --port 4000 --host 0.0.0.0'
end

task :servequick do
  sh 'bundle exec jekyll serve --config _config.yml --watch --trace --limit_posts 3 --port 40000 --host 0.0.0.0'
end
