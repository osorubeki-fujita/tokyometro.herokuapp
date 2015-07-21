class BarrierFreeFacility::Type < ActiveRecord::Base

  has_many :infos , class: ::BarrierFreeFacility::Info , foreign_key: :type_id

  ::OdptCommon::Modules::Dictionary::Common::BarrierFree.facility_types.each do | method_base_name |
    eval <<-DEF
      def #{ method_base_name }?
        name_en.underscore == "#{ method_base_name }"
      end
    DEF
  end

end

# 車いす
# http://www.flaticon.com/free-icon/wheelchair_25332

# トイレ
# http://www.meisora.co.jp/tc/icon_download.html

# http://www.ecomo.or.jp/barrierfree/pictogram/picto_001.html
# http://www.ecomo.or.jp/barrierfree/pictogram/picto_prioritytop.html
