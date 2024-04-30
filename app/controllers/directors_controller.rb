class DirectorsController < ApplicationController
  def index
    matching_directors = Director.all
    @list_of_directors = matching_directors.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    render({ :template => "director_templates/show" })
  end

  def update
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    name_new = params.fetch("query_name")
    date_new = params.fetch("query_dob")
    bio_new = params.fetch("query_bio")
    image_new = params.fetch("query_image")

    @the_director.name = name_new
    @the_director.dob = date_new
    @the_director.bio = bio_new
    @the_director.image = image_new
    @the_director.save

    redirect_to("/directors/#{the_id}")
  end

  def delete
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    the_director = matching_directors.at(0)

    the_director.destroy

    redirect_to("/directors")
  end

  def max_dob
    directors_by_dob_desc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :desc })

    @youngest = directors_by_dob_desc.at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    directors_by_dob_asc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :asc })

    @eldest = directors_by_dob_asc.at(0)

    render({ :template => "director_templates/eldest" })
  end

  def insert
    name_new = params.fetch("query_name")
    date_new = params.fetch("query_dob")
    bio_new = params.fetch("query_bio")
    image_new = params.fetch("query_image")
    director_new = Director.new

    director_new.name = name_new
    director_new.dob = date_new
    director_new.bio = bio_new
    director_new.image = image_new

    director_new.save

    redirect_to("/directors")
  end
end
