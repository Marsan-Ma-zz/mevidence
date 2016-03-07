# Learn more: http://github.com/javan/whenever
env "PATH", ENV["PATH"] # for http://blog.lucashungaro.com/2012/04/10/capistrano-and-whenever-updating-the-crontab-of-the-runner-user/

# solve logout then cron died problem, http://blog.scoutapp.com/articles/2010/09/07/rvm-and-cron-in-production#dsq-comment-138101845
set :job_template, "bash -l -i -c ':job'"
set :output, "~/cron_log.log"

#=============================
#   WEB Server Job
#=============================
if Socket.gethostname.in?(['Mevidence'])
  every 1.day, :at => [7,19].map{|i| "#{i}:00"} do
    rake "-s sitemap:refresh"
  end
end


