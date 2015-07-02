class Station::NameAlias < ActiveRecord::Base
  include ::Association::To::Station::Info
end