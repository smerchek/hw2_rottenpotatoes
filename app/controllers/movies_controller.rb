class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.all_ratings()
    @sortBy = params[:sort_by]
    @ratings = params[:ratings]

    if @ratings.nil?
      @ratings = session[:ratings] || @all_ratings
      should_redirect = true
    else
      session[:ratings] = @ratings
    end
    
    if @sortBy.nil?
      @sortBy = session[:sort_by] || :id
      should_redirect = true
    else
      session[:sort_by] = @sortBy
    end

    if should_redirect
      redirect_to movies_path(:ratings => @ratings, :sort_by => @sortBy)
    else
      @movies = Movie.all(:order => @sortBy + " ASC", :conditions => { :rating => @ratings.keys})
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
