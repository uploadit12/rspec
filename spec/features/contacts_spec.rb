require 'spec_helper'

feature 'Contact Management' do

  scenario 'lists all the contacts' do
    Contact.create(first_name: 'Rahul', last_name: 'Dravid', email: 'rahul.dravid@gmail.com')
    visit contacts_path
    page.should have_content 'Rahul'
    page.should have_content 'Dravid'
    page.should have_content 'rahul.dravid@gmail.com'
  end


  scenario 'shows requested contact' do
    contact = Contact.create(
      first_name: 'Rahul', last_name: 'Dravid', email: 'rahul.dravid@gmail.com'
    )
    visit contacts_path
    within 'tbody tr' do
      click_link 'Show'
    end
    page.should have_content 'Rahul'
    page.should have_content 'Dravid'
    page.should have_content 'rahul.dravid@gmail.com'
  end

  scenario 'adds new contact' do
    visit contacts_path
    expect {
      click_link 'New Contact'
      fill_in 'First name', with: 'Rahul'
      fill_in 'Last name', with: 'Dravid'
      fill_in 'Email', with: 'rahul.dravid@cc.com'
      click_button 'Create Contact'
      }.to change(Contact, :count).by(1)
    current_path.should eq contact_path(Contact.last)
    page.should have_content 'Contact was successfully created'
  end

  scenario 'delete requested contact', js: true do
    contact = Contact.create(
      first_name: 'Rahul', last_name: 'Dravid', email: 'rahul.dravid@gmail.com'
    )
    visit contacts_path
    within 'tbody tr' do
      click_link 'Destroy'
    end
    page.driver.browser.switch_to.alert.accept
    current_path.should eq contacts_path
    page.should have_content 'Contact was successfully destroyed'
  end

  scenario 'updates existing record' do
    contact = Contact.create(
      first_name: 'Rahul', last_name: 'Dravid', email: 'rahul.dravid@gmail.com'
    )
    visit contacts_path
    within 'tbody tr' do
      click_link 'Edit'
    end
    fill_in 'First name', with: 'Sachin'
    fill_in 'Last name', with: 'Tendulkar'
    click_button 'Update Contact'
    current_path.should eq contact_path(contact)
    page.should have_content 'Sachin'
    page.should have_content 'Tendulkar'
  end

  scenario 'block the requested contact' do
    contact = Contact.create(
      first_name: 'Rohan', last_name: 'Gavaskar'
    )
    visit contacts_path
    within 'tbody tr' do
      click_link 'Block'
    end
    current_path.should eq contacts_path
    page.should have_content 'Contact was successfully blocked'
    page.should_not have_content 'Rohan'
  end
end
