class PointDecorator < Draper::Decorator
  delegate_all
  
  def render_in_station_facility_page
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
%p<
  = this.text_ja
%p<
  = this.text_en
    HAML
  end

end