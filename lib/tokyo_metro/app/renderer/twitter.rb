class TokyoMetro::App::Renderer::Twitter < TokyoMetro::App::Renderer::MetaClass

  def initialize( request , setting , railway_lines = nil , visibility: :visible )
    raise "Error" unless setting == :tokyo_metro or setting == :railway_lines
    raise "Error" if setting == :railway_lines and railway_lines.blank?
    raise "Error" unless visibility == :visible or :hidden
    super( request )
    @setting = setting
    @railway_lines = railway_lines
    @visibility = visibility
  end

  def render
    h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ id: :twitters , class: visibility }
  = ::TokyoMetro::App::Renderer::Twitter::Header.new( request , visibility: visibility ).render
  %div{ id: :twitter_accounts }
    - # %ul{ id: :twitter_tabs_for_each_acount }
    - #   %li{ id: :twitter_tab_tokyo_metro }<
    - #    = ::Operator.tokyo_metro.decorate.render_logo
    - if setting == :tokyo_metro
      %div{ id: :tweets_of_tokyo_metro , class: :twitter_account }
        = ::ApplicationHelper.tokyo_metro.decorate.render_twitter_widget
    - elsif setting == :railway_lines
      - if railway_lines.length == 1
        = railway_lines.first.decorate.render_twitter_widget
      - else
        - railway_lines.each do | railway_line |
          = railway_line.decorate.render_twitter_widget
  = ::TwitterAccountDecorator.embed_twitter_script
    HAML
  end

  private

  def h_locals
    super.merge( {
      setting: @setting ,
      railway_lines: railway_lines_to_render ,
      visibility: @visibility
    } )
  end

  def railway_lines_to_render
    unless @setting == :railway_lines
      return nil
    end

    if @railway_lines.map( &:same_as ).include?( "odpt.Railway:TokyoMetro.MarunouchiBranch" )
      if @railway_lines.length == 1
        return ::RailwayLine.where( same_as: "odpt.Railway:TokyoMetro.Marunouchi" )
      else
        return @railway_lines.where.not( same_as: "odpt.Railway:TokyoMetro.MarunouchiBranch" )
      end
    end

    if @railway_lines.map( &:same_as ).include?( "odpt.Railway:TokyoMetro.ChiyodaBranch" )
      if @railway_lines.length == 1
        return ::RailwayLine.where( same_as: "odpt.Railway:TokyoMetro.Chiyoda" )
      else
        return @railway_lines.where.not( same_as: "odpt.Railway:TokyoMetro.ChiyodaBranch" )
      end
    end

    return @railway_lines
  end

end