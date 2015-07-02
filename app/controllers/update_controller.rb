class UpdateController < ApplicationController

  def real_time_infos
    respond_to do | format |
      format.js { render :layout => nil }
    end
  end

end
