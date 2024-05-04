desc "Deploy this sample app to heroku"
task :deploy do
  `git push heroku main`
end

