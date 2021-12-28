class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :update, :destroy]

  # GET /articles
  def index
    @articles = Article.all

    if(params[:_limit])
      @articles = @articles.limit(params[:_limit])
    end

    render json: @articles, include: [:events, :launches ]
  end

  # GET /articles/1
  def show
    render json: @article, include: [:events, :launches ]
  end

  # POST /articles
  def create
    @article = Article.new(article_params)
    @article.origin_id = params[:article]['id']

    if @article.save

      events = params[:article]['events']
      events.each do |event|
        if Event.where(origin_id: event[:id]).empty?
          @event = Event.new(origin_id:event[:id], provider: event[:provider])
          @event.save

          @articles_event = ArticlesEvent.new(article: @article, event: @event)
          @articles_event.save
        else
          @event = Event.where(origin_id: event[:id]).first
          @articles_event = ArticlesEvent.new(article: @article, event: @event)
          @articles_event.save
        end
      end 

      launches = params[:article]['launches']
      launches.each do |launch|
        if Launch.where(origin_id: launch[:id]).empty?
          @launch = Launch.new(origin_id:launch[:id], provider: launch[:provider])
          @launch.save

          @articles_launches = ArticlesLaunch.new(article: @article, launch: @launch)
          @articles_launches.save
        else
          @launch = Launch.where(origin_id: launch[:id]).first
          @articles_launches = ArticlesLaunch.new(article: @article, launch: @launch)
          @articles_launches.save
        end
      end 

      render json: @article, status: :created, location: @article, include: [:events, :launches ]
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /articles/1
  def update
    if @article.update(article_params)
      render json: @article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # DELETE /articles/1
  def destroy
    @article.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(
        :featured, :origin_id, :title, 
        :url, :imageUrl, :newsSite, 
        :summary, :publishedAt, :events)
    end
end
