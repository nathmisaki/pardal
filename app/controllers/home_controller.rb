class HomeController < ApplicationController

  before_filter :authenticate_user!

  def index
    #redirect_to "/v3/index.php"
  end

end
