require 'sinatra/base'
require 'sinatra/activerecord'
require 'date'
require './models/user.rb' # your models
# require 'json' #json support

class MyApplication < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  enable :sessions


  #:nocov:
  configure :production,:staging do
    set :database, ENV['DATABASE_URL']
  end

  configure :development do
    set :database, 'sqlite:///dev.db'
  end
  #:nocov:

  configure :test do
    set :database, 'sqlite:///dev.db'
  end

  get '/' do
    erb :home
  end

  get '/new' do
    erb :event_new
  end

  post '/new' do
    user = "somebody@someplace.com"    
    name = params[:name]
    date = Date.parse(params[:date])
    event = Event.new
    event.name = name
    event.date = date
    event.user = user
    event.save
    @message = "Event created"
    erb :operation_result
  end

  get '/events' do
    @list = Event.all
    erb :event_list
  end

  #-------------------log in-----------------------------#

  get '/main_page_l' do
      if session[:user] == nil
          erb :home
      else 
          erb :main
      end
  end

  post '/main_page_l' do
       username_exist = false
       current_user = nil 
       users = User.all
       users.each do |user|
          if user.username == params[:username] #primero verifico si el username existe
              username_exist = true             #si no existe, lanza error de usuario
              current_user = user
          end
       end
       
       if username_exist
             if current_user.password == params[:password] #si el username existe y es el
                   session[:user] = current_user.username
                   erb :main                               #password correcto, me lleva al 
             else erb :error_password_wrong                #main page
             end                                           #si no es correcto, lanza error de
       else                                                #contraseña
             erb :error_username_dont_exists   
       end 
  end

  #-------------------Sign in-----------------------------#

  get '/sign_in_page' do
       erb :sign_in  
  end
  
  get '/main_page_s' do
      if session[:user] == nil
          erb :home
      else 
          erb :main
      end
  end

  post '/main_page_s' do 
       user = User.find_by_username(params[:username])
       if user != nil
          erb :error_username_exists
       else 
            user = User.new
            user.username = params[:username]
            user.password = params[:password]
            user.save
            session[:user] = user.username
            erb :main
       end 
  end


end
