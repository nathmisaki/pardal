class HelpsController < InheritedResources::Base
  def show
    @help = Help.find_by_page(params[:id])
    super do |format|
      format.html { request.xhr? ? render(:show, :layout => false) : render(:show)}
    end
  end
end
