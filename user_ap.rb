require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"
require "yaml"

before do
  @file = YAML.load(File.read("users.yaml"))
  @users = @file.keys
end

helpers do
  def count_interests
    @file.map { |_, info| info[:interests] }.flatten.size
  end
end

get "/" do
  @title = "Users and Interests"
  
  erb :home
end

get '/:user' do
  @user = params[:user]
  @info = @file[@user.to_sym]
  @email = @info[:email]
  @interests = @info[:interests]
  
  redirect "/" unless @users.include?(@user.to_sym)
  
  erb :user
  # @file[@user.to_sym].inspect
  # @user.to_sym.inspect
end