require 'kconv'

result = ''

result << @datum.attribute_names.join( ',' )
result << "\r"

@datum.all.each do | d |
  result << d.attributes.values.join( ',' )
  result << "\r"
end

result.kconv( ::Kconv::SJIS , Kconv::UTF8 )
