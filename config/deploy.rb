# config valid only for current version of Capistrano
lock '3.1.0'

set :application, 'prejournal'
set :repo_url, 'git@github.com:kenshero/prejournal.git'
set :rbenv_path, '/home/ejadmin/.rbenv/'
set :ssh_options, { :forward_agent => true }
set :deploy_to, '/home/ejadmin/prejournal'
set :deploy_via, :copy
set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'
end