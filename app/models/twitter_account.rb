class TwitterAccount < ActiveRecord::Base
  belongs_to :operator_or_railway_line , polymorphic: true
end