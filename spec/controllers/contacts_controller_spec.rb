require 'spec_helper'

describe ContactsController do
  describe 'GET index' do
    it 'assign array of Contact to @contact' do
      watson = create(:contact, last_name: 'Watson')
      anderson = create(:contact, last_name: 'Anderson')
      get :index
      assigns(:contacts).should eq([anderson, watson])
    end
  end

  describe 'GET show' do
    it 'assign requested contact to @contact' do
      contact = create(:contact)
      get :show, {id: contact}
      assigns(:contact).should eq contact
    end
  end

  describe 'GET new' do
    it 'assign new contact to @contact' do
      get :new
      assigns(:contact).should be_a_new(Contact)
    end
  end

  describe 'GET edit' do
    it 'assign requested contact to @contact' do
      contact = create(:contact)
      get :show, {id: contact}
      assigns(:contact).should eq contact
    end
  end

  describe 'POST create' do
    describe 'valid params' do
      it 'creates a new contact' do
        lambda {
          post :create, { contact: attributes_for(:contact) }
        }.should change(Contact, :count).by(1)
      end
      it 'assigns newly created Contact to @contact' do
        post :create, { contact: attributes_for(:contact) }
        assigns(:contact).should be_a(Contact)
        assigns(:contact).should be_persisted
      end
      it 'redirects to contact show' do
        post :create, { contact: attributes_for(:contact) }
        response.should redirect_to Contact.last
      end
    end

    describe 'invalid params' do
      it 'assigns unsaved Contact to @contact'
      it 're-renders the new template'
    end
  end
end
