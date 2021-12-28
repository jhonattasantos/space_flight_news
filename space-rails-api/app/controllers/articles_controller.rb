class ArticlesController < ApplicationController
  
  include Paginable

  before_action :set_article, only: [:show, :update, :destroy]

  # GET /articles
  def index
    @articles = Article.page(current_page).per(per_page)
    render json: { data: @articles, meta: meta_attributes(@articles) }, include: [:events, :launches ]
  end

  # GET /articles/1
  def show
    render json: @article, include: [:events, :launches ]
  end

  # POST /articles
  def create

    article_found = Article.where(origin_id: params[:id])
    if !article_found.empty?
      return render status: :no_content
    end

    @article = Article.new(article_params)
    @article.origin_id = params[:article]['id']

    if @article.save

      launches = params[:launches]
      if launches
        launches.each do |launch|
          launches_found = Launch.where(origin_id: launch[:id])
          if launches_found.empty?
            @article.launches << Launch.new(origin_id: launch[:id], provider: launch[:provider])
          else
            @article.launches << launches_found.first
          end
        end
      end

      events = params[:events]
      if events
        events.each do |events|
          events_found = Event.where(origin_id: events[:id])
          if events_found.empty?
            @article.events << Event.new(origin_id: events[:id], provider: events[:provider])
          else
            @article.events << events_found.first
          end
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
        :summary, :publishedAt, :events,
        :launches)
    end
end
