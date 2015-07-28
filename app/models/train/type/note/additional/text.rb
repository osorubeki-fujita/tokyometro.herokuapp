class Train::Type::Note::Additional::Text < ActiveRecord::Base
  has_many :note_additional_infos , class: ::Train::Type::Note::Additional::Info , foreign_key: :additional_note_text_id
  has_many :note_infos , class: ::Train::Type::Note::Info , through: :note_additional_infos
end
