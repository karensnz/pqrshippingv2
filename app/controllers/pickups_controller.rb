class PickupsController < ApplicationController
  def index
    @pickups = Pickup.all

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
