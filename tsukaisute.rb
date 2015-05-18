::Point::Code.all.each do | item |
  item.destroy
end

::Point::Info.all.each do | item |
  if item.code.present? or item.additional_name_id.present?
    code_id = ::Point::Code.find_or_create_by( main: item.code , additional_name_id: item.additional_name_id ).id
    item.update( code_id: code_id )
  end
end
