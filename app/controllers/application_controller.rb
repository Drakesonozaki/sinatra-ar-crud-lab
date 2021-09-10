
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect to "/articles"
  end

  
  get "/articles" do
    @articles = Article.all
    erb :index
  end

  
  get "/articles/new" do
    @article = Article.new
    erb :new
  end

  # create action
  post "/articles" do
    @article = Article.create(params)
    redirect to "/articles/#{ @article.id }"
  end

  # display action
  get "/articles/:id" do
    @article = Article.find(params[:id])
    erb :show #remember to create show.erb
  end

  # editor action
  get "/articles/:id/edit" do
    @article = Article.find(params[:id])
    erb :edit 
  end

  # change action
  patch "/articles/:id" do
    @article = Article.find(params[:id])
    @article.update(params[:article])
    redirect to "/articles/#{ @article.id }"
  end

  #delete action
  delete "/articles/:id" do
    Article.destroy(params[:id])
    redirect to "/articles" #upon deletion sends the user back to the /articles path.
  end


end