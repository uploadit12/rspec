require 'spec_helper'

describe Phone do
  it 'should not allow duplicate phone number per contact' do
    contact = create(:contact)
    create(:phone, contact: contact, phone: '123-123')
    build(:phone, contact: contact, phone: '123-123').should_not be_valid
  end

  it 'should allow same phone number for seprate contact' do
    create(:phone, phone: '123-123')
    build(:phone, phone: '123-123').should be_valid
  end
end
