class HelpsController < InheritedResources::Base
  layout nil

  def show
    @help = Help.find_by_page(params[:id])
    super
  end
end
