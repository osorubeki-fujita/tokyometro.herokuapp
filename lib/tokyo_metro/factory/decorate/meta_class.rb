class TokyoMetro::Factory::Decorate::MetaClass

  include Rails.application.routes.url_helpers

  # @note link_to , link_to_unless_current , url_for , current_page?
  @@action_view_base = ::ActionView::Base.new

  # @return [::Module]
  @@action_view_helpers = ::ActionView::Helpers::UrlHelper

  # @return [::ActionController::Base]
  # @note url_for
  @@action_controller_base = ::ActionController::Base.new

  # @return [::Module]
  # @note url_for
  @@url_helpers = ::Rails.application.routes.url_helpers

  # @return [::ActionView::Base]
  # @note オリジナルの helper メソッド
  # @note url_for は利用不可
  @@application_controller_helper = ::ApplicationController.helpers

  def initialize( request )
    @request = request
  end

  attr_reader :request

  private

  def default_url_options
    ::ActionController::Base.default_url_options
  end

  def h_locals
    {
      request: @request ,
      default_url_options: default_url_options ,
      h: h ,
      u: u ,
      c: c ,
      v: v
    }
  end

  def path
    ::Rails.application.routes.recognize_path( @request.referer )
  end

  def v
    @@action_view_base
  end

  def c
    @@action_controller_base
  end

  def u
    @@url_helpers
  end

  def url_helpers
    @@url_helpers
  end

  def h
    @@application_controller_helper
  end

  class << self

    private

    def default_url_options
      ::ActionController::Base.default_url_options
    end

    def v
      @@action_view_base
    end
  
    def c
      @@action_controller_base
    end
  
    def u
      @@url_helpers
    end
  
    def url_helpers
      @@url_helpers
    end
  
    def h
      @@application_controller_helper
    end

  end

end