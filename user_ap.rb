require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"
require "yaml"

before do
  @file = YAML.load(File.read("users.yaml"))
  @users = @file.keys
end

get "/" do
  @title = "Users and Interests"
  
  erb :home
end

get '/:user' do
  @user = params[:user]
  
  redirect "/" unless @users.include?(@user.to_sym)
  
  erb :user
  # @file[@user.to_sym].inspect
  # @user.to_sym.inspect
end