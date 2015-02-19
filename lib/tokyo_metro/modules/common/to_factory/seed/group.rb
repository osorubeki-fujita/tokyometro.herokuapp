# DB に配列、ハッシュを流し込むためのモジュール
# @note {TokyoMetro::Modules::Common::ToFactory::Seed::Hash} , {TokyoMetro::Modules::Common::ToFactory::Seed::List} で使用
module TokyoMetro::Modules::Common::ToFactory::Seed::Group

  def seed(
    *variables ,
    # factory_name
    class_name: self.class ,
    # method_name
    indent: 0 ,
    no_display: false ,
    not_on_the_top_layer: false ,
    display_number: true ,
    other_info: nil ,
    interrupt: false
  )
    __seed__(
      *variables ,
      factory_name: :factory_for_seeding_this_class ,
      class_name: class_name ,
      method_name: __method__ ,
      indent: indent ,
      no_display: no_display ,
      not_on_the_top_layer: not_on_the_top_layer ,
      display_number: display_number ,
      other_info: other_info ,
      interrupt: interrupt
    )
  end

  private

  def __seed__(
    *args ,
    factory_name: :factory_for_seeding_this_class ,
    class_name: self.class ,
    method_name: __method__  ,
    indent: 0 ,
    no_display: false ,
    not_on_the_top_layer: false ,
    display_number: true ,
    other_info: nil ,
    interrupt: interrupt
  )
    self.class.send( factory_name ).process( self , *args , class_name , method_name , indent , no_display , not_on_the_top_layer , display_number , other_info , interrupt )
  end

end