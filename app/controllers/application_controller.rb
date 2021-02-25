
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/articles' do
    erb :index
  end

  post  '/articles' do
    @newarticle = Article.create(params[:article])
    redirect "articles/#{@newarticle.id}"
  end

  get "/articles/new" do
    erb :new
  end

  get "/articles/:id" do
    @article = Article.find_by(id: params[:id])
    if !@article
      redirect '/articles'
    end
    erb :show
  end

  get "/articles/:id/edit" do
    @article = Article.find_by(id: params[:id])
    if !@article
      redirect '/articles'
    end
    erb :edit
  end

  patch "/articles/:id" do
      @article = Article.find_by(id: params[:id])
      @article.update(params[:article])
      erb :show
  end

  delete "/articles/:id" do
    article = Article.find_by(id: params[:id])
    article.destroy
    redirect "/articles"
  end


end
