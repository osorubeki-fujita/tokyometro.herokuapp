class Train::Type::Note::Additional::Info < ActiveRecord::Base
  belongs_to :note_info , class: ::Train::Type::Note::Info
  belongs_to :additional_text , class: ::Train::Type::Note::Additional::Text

  default_scope -> {
    order( :index )
  }

end
