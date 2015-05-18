class Point::Code < ActiveRecord::Base

  include ::Association::To::Point::Infos
  belongs_to :additional_name , class: ::Point::AdditionalName

  def has_additional_name?
    additional_name.present?
  end

  def code_of_number_and_alphabet?
    /\A[a-zA-z\d]+\Z/ === main
  end

  def main_to_s
    main
  end

end
