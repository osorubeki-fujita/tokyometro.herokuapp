module TokyoMetro::CommonModules::Info::Decision::CompareBase

  private

  def compare_base( *args , compared )
    raise if args.empty?
    args = args.flatten

    unless args.instance_of?( ::Array ) and args.all? { | item | item.instance_of?( ::String ) or item.instance_of?( ::Regexp ) }
      class_list = args.map { | item | item.class }
      raise "#{ class_list.to_s } is not valid." 
    end
    raise unless compared.instance_of?( ::String ) or ( compared.instance_of?( ::Array ) and compared.all? { | item | item.instance_of?( ::String ) } )
    if compared.instance_of?( ::String )
      args.any? { | item | item === compared }
    else
      compared.any? { | compared_each_item |
        args.any? { | item | item === compared_each_item }
      }
    end
  end

end