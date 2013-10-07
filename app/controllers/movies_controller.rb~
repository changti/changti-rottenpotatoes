class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
	@all_ratings = Movie.ratings
	@order = params[:order]
    @filtered_ratings = Array.new
    @ratings_hash = Hash.new

    if (params[:order]) != nil
      session[:order] = params[:order]
    end

    if (params[:ratings]) != nil
       params[:ratings].each_key { |r| @filtered_ratings.push(r); @ratings_hash[r] = r; }
		if @order == "title"
			@movies = Movie.find(:all, :conditions => {:rating => @filtered_ratings}, :order => "title")
		elsif @order == "release_date"
			@movies = Movie.find(:all, :conditions => {:rating => @filtered_ratings},  :order => "release_date")	
		else
			@movies = @filtered_ratings.nil? ? Movie.all : Movie.find(:all, :conditions => {:rating => @filtered_ratings}, :order=>@order)
		end
       session[:ratings] = @ratings_hash
    elsif (session[:ratings])
         flash.keep
         redirect_to movies_path(:order=>session[:order], :ratings=>session[:ratings])
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
