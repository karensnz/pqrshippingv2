class PickupsController < ApplicationController
  before_action :current_user_must_be_pickup_user, :only => [:edit, :update, :destroy]

  def current_user_must_be_pickup_user
    pickup = Pickup.find(params[:id])

    unless current_user == pickup.user
      redirect_to :back, :alert => "You are not authorized for that."
    end
  end

  def index
    @pickups = current_user.pickups.page(params[:page]).per(10)
    @location_hash = Gmaps4rails.build_markers(@pickups.where.not(:package_destination_latitude => nil)) do |pickup, marker|
      marker.lat pickup.package_destination_latitude
      marker.lng pickup.package_destination_longitude
      marker.infowindow "<h5><a href='/pickups/#{pickup.id}'>#{pickup.created_at}</a></h5><small>#{pickup.package_destination_formatted_address}</small>"
    end

    render("pickups/index.html.erb")
  end

  def show
    @pickup = Pickup.find(params[:id])

    render("pickups/show.html.erb")
  end

  def new
    @pickup = Pickup.new

    render("pickups/new.html.erb")
  end

  def create
    @pickup = Pickup.new

    @pickup.user_id = params[:user_id]
    @pickup.date = params[:date]
    @pickup.materials_needed = params[:materials_needed]
    @pickup.package_destination = params[:package_destination]
    @pickup.image_upload = params[:image_upload]
    @pickup.special_instructions = params[:special_instructions]

    save_status = @pickup.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/pickups/new", "/create_pickup"
        redirect_to("/pickups")
      else
        redirect_back(:fallback_location => "/", :notice => "Pickup created successfully.")
      end
    else
      render("pickups/new.html.erb")
    end
  end

  def edit
    @pickup = Pickup.find(params[:id])

    render("pickups/edit.html.erb")
  end

  def update
    @pickup = Pickup.find(params[:id])

    @pickup.user_id = params[:user_id]
    @pickup.date = params[:date]
    @pickup.materials_needed = params[:materials_needed]
    @pickup.package_destination = params[:package_destination]
    @pickup.image_upload = params[:image_upload]
    @pickup.special_instructions = params[:special_instructions]

    save_status = @pickup.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/pickups/#{@pickup.id}/edit", "/update_pickup"
        redirect_to("/pickups/#{@pickup.id}", :notice => "Pickup updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Pickup updated successfully.")
      end
    else
      render("pickups/edit.html.erb")
    end
  end

  def destroy
    @pickup = Pickup.find(params[:id])

    @pickup.destroy

    if URI(request.referer).path == "/pickups/#{@pickup.id}"
      redirect_to("/", :notice => "Pickup deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Pickup deleted.")
    end
  end
end
