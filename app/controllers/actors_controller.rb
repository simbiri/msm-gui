class ActorsController < ApplicationController
  def index
    matching_actors = Actor.all
    @list_of_actors = matching_actors.order({ :created_at => :desc })

    render({ :template => "actor_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })
    @the_actor = matching_actors.at(0)

    render({ :template => "actor_templates/show" })
  end

  def update
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })
    @the_actor = matching_actors.at(0)

    name_new = params.fetch("query_name")
    date_new = params.fetch("query_dob")
    bio_new = params.fetch("query_bio")
    image_new = params.fetch("query_image")

    @the_actor.name = name_new
    @the_actor.dob = date_new
    @the_actor.bio = bio_new
    @the_actor.image = image_new
    @the_actor.save

    redirect_to("/actors/#{the_id}")
  end

  def delete
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })
    the_actor = matching_actors.at(0)
    the_actor.destroy

    redirect_to("/actors")
  end

  def insert
    name_new = params.fetch("query_name")
    date_new = params.fetch("query_dob")
    bio_new = params.fetch("query_bio")
    image_new = params.fetch("query_image")
    actor_new = Actor.new

    actor_new.name = name_new
    actor_new.dob = date_new
    actor_new.bio = bio_new
    actor_new.image = image_new

    actor_new.save

    redirect_to("/actors")
  end
end
