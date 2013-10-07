class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
	@all_ratings = Movie.ratings
	@order = params[:order]

	if params[:order] != nil
		session[:order] = params[:order]
	end

	if params[:ratings] != nil
		session[:ratings] = params[:ratings]
		flash.keep
		redirect_to movies_path({:order => @order, :ratings => @ratings})
	end

	@ratings = session[:ratings]

	if @order == "title"
		@movies = Movie.find(:all, :order => "title")  
	elsif @order == "release_date"
		@movies = Movie.find(:all, :order => "release_date")			
	else
		@movies = @ratings.nil? ? Movie.all : Movie.find_all_by_rating(@ratings.map {|r| r[0]})
	end

  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
