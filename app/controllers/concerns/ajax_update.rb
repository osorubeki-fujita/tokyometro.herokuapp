module AjaxUpdate

  extend ActiveSupport::Concern

  included do

    def update_info
      sleep(0.2)
      @time_now = Time.now
      @last_update = Time.now
      @next_update = Time.now
    end

  end

end