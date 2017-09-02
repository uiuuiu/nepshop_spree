set :port, 22
set :user, 'root'
set :deploy_via, :remote_cache
set :use_sudo, false
server '45.76.158.224', user: 'root', roles: %{web app}, primary: true
set :ssh_options, {
	user: 'root',
	forward_agent: true,
	auth_methods: %w{password},
	password: '!4tKTmW1@cFBHKsE'
}
set :rails_env, :production