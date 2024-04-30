class MoviesController < ApplicationController
  def index
    matching_movies = Movie.all
    @list_of_movies = matching_movies.order({ :created_at => :desc })

    render({ :template => "movie_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })
    @the_movie = matching_movies.at(0)

    render({ :template => "movie_templates/show" })
  end

  def update
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })
    @the_movie = matching_movies.at(0)

    title_new = params.fetch("query_title")
    year_new = params.fetch("query_year")
    duration_new = params.fetch("query_duration")
    desc_new = params.fetch("query_description")
    image_new = params.fetch("query_image")
    dir_id_new = params.fetch("query_director_id")

    @the_movie.description = desc_new
    @the_movie.duration = duration_new
    @the_movie.image = image_new
    @the_movie.title = title_new
    @the_movie.year = year_new
    @the_movie.director_id = dir_id_new

    @the_movie.save
    redirect_to("/movies/#{the_id}")
  end

  def delete
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })
    the_movie = matching_movies.at(0)

    the_movie.destroy
    redirect_to("/movies")
  end

  def insert
    title_new = params.fetch("query_title")
    year_new = params.fetch("query_year")
    duration_new = params.fetch("query_duration")
    desc_new = params.fetch("query_description")
    image_new = params.fetch("query_image")
    dir_id_new = params.fetch("query_director_id")

    movie_new = Movie.new
    movie_new.description = desc_new
    movie_new.duration = duration_new
    movie_new.image = image_new
    movie_new.title = title_new
    movie_new.year = year_new
    movie_new.director_id = dir_id_new

    movie_new.save
    redirect_to("/movies")
  end
end
