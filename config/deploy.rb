# frozen_string_literal: true

require 'mina/rails'
require 'mina/git'
require 'mina/version_managers/rbenv'

set :application_name, 'ny_2022'
set :domain, '89.253.218.107'
set :user, 'deploy'
set :deploy_to, '/usr/share/nginx/ny_2022'
set :repository, 'git@github.com:TailsSavarin/ny-2022.git'
set :branch, ENV.fetch('BRANCH', 'main')

set :shared_dirs, fetch(:shared_dirs, []).push(
  'node_modules',
  'storage'
)

set :shared_files, fetch(:shared_files, []).push(
  'config/database.yml',
  'config/credential.yml.enc',
  'config/master.key',
  '.env'
)

task :remote_environment do
  command %(source $HOME/.zshrc)
  command %(eval `ssh-agent -s`)
  command %(ssh-add ~/.ssh/id_ny_2022)
end

desc 'Deploys the current version to the server.'
task :deploy do
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    command %(npm install)
    command %(bin/vite clobber)
    command %(bin/vite build)
    invoke :'deploy:cleanup'

    on :launch do
      in_path(fetch(:current_path)) do
        command %(mkdir -p tmp/)
        command %(touch tmp/restart.txt)
      end
    end
  end
end
