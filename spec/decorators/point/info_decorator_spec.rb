require 'rails_helper'

describe Point::InfoDecorator do

  id_urns = ::Point::Info.all.pluck( :id_urn )
  regexp = ::Point::InfoDecorator::REGEXP_FOR_MAKING_ID_URN_ON_HTML

  replaced_id_urns = ::Point::Info.all.to_a.map( &:decorate ).map { | decorator | decorator.send( :id_urn_on_html ) }

  it 'has id_urn attribute in model object.' do
    expect( id_urns.all? { | id_urn | regexp === id_urn } ).to be true
  end

  it 'has id_urn attribute that matches with regexp in model object' do
    expect( replaced_id_urns.length ).to eq( replaced_id_urns.uniq.length )
  end

end
