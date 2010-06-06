class HelpsController < InheritedResources::Base
  def show
    @help = Help.find_page(params[:id])
    super do |format|
      format.html do
        if request.xhr?
          render(:show, :layout => false)
        else
          render(:show)
        end
      end
    end
  end
end
