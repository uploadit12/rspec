require 'spec_helper'

describe Contact do
  it 'has a valid factory' do
    create(:contact).should be_valid
  end

  it 'should be invalid without first_name' do
    build(:contact, first_name: nil).should_not be_valid
  end

  it 'should be invalid without last_name' do
    build(:contact, last_name: nil).should_not be_valid
  end

  it 'returns contact full name as string' do
    contact = build(:contact, first_name: 'Shane', last_name: 'Watson')
    contact.full_name.should eq 'Shane Watson'
  end

  it 'should not allow contact with duplicate email_id' do
    create(:contact, email: 'shane@cc.com')
    build(:contact, email: 'shane@cc.com').should_not be_valid
  end

  it 'returns all un blocked records' do
    contact1 = create(:contact)
    contact2 = create(:contact, blocked: true)
    Contact.active.should eq [contact1]
  end

  describe 'search and order by last name' do
    before :each do
      @jhanson = create(:contact, last_name: 'Jhanson')
      @sam = create(:contact, last_name: 'Sam')
      @sanju = create(:contact, last_name: 'Sanju')
    end
    context 'matching letter' do
      it 'returns the matched records ordered by last_name' do
        Contact.search_and_order_by_last_name('S').should eq [@sam, @sanju]
      end
    end

    context 'non matching letter' do
      it 'does not return a record' do
        Contact.search_and_order_by_last_name('S').should_not include @jhanson
      end
    end
  end
end
