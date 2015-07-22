class TwitterAccount < ActiveRecord::Base
  belongs_to :operator_info_or_railway_line_info , polymorphic: true
end
