class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include TwitterProcessor

  def index
    set_twitter_processor( :tokyo_metro )
    @station_infos = ::Station::Info.all.where( operator_id: ::ApplicationHelper.tokyo_metro.id )
    render 'index' , layout: 'application'
  end

  def disclaimer
    @title = "免責事項"
    render 'disclaimer' , layout: 'application'
  end

  def remark
    @title = "ご利用上の注意"
    render 'remark' , layout: 'application'
  end

end
