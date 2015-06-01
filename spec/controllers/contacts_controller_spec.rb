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
      it 'redirects to contact show action' do
        post :create, { contact: attributes_for(:contact) }
        response.should redirect_to Contact.last
      end
    end

    describe 'invalid params' do
      it 'assigns unsaved Contact to @contact' do
        post :create, { contact: attributes_for(:contact, first_name: nil)}
        assigns(:contact).should be_a(Contact)
        assigns(:contact).should be_new_record
      end
      it 're-renders the new template' do
        post :create, { contact: attributes_for(:contact, first_name: nil) }
        response.should render_template :new
      end
    end

    describe 'PUT update' do
      before :each do
        @contact = create(:contact)
      end

      it 'assigns requested Contact to @contact' do
        put :update, {id: @contact, contact: attributes_for(:contact)}
        assigns(:contact).should eq @contact
      end

      describe 'valid params' do
        it 'updates existing record' do
          put :update, {id: @contact, contact: attributes_for(:contact, first_name: 'James')}
          @contact.reload
          @contact.first_name.should eq 'James'
        end

        it 'redirects to contact show action' do
          put :update, {id: @contact, contact: attributes_for(:contact)}
          response.should redirect_to @contact
        end
      end

      describe 'invalid parameters' do
        it 'does not update the requested record' do
          put :update, {id: @contact, contact: attributes_for(:contact, first_name: 'James Anderson')}
          @contact.reload
          @contact.first_name.should_not eq 'James Anderson'
        end

        it 'renders edit template' do
          put :update, {id: @contact, contact: attributes_for(:contact, first_name: 'James Anderson')}
          response.should render_template :edit
        end
      end
    end

    describe 'DELETE destroy' do
      before :each do
        @contact = create(:contact)
      end

      it 'destroys the requested contact' do
        lambda {
          delete :destroy, id: @contact
        }.should change(Contact, :count).by(-1)
      end

      it 'redirects to contact list page' do
        delete :destroy, id: @contact
        response.should redirect_to(contacts_url)
      end
    end
  end
end
