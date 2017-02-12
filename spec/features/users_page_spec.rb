require 'rails_helper'

include Helpers

describe "User" do
  before :each do
    FactoryGirl.create :user
  end

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username:"Pekka", password:"Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username:"Pekka", password:"wrong")
      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'username and password do not match'

    end
  end

  it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', with:'Brian')
    fill_in('user_password', with:'Secret55')
    fill_in('user_password_confirmation', with:'Secret55')

    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
  end

  it "can see ratings" do
    brewery = FactoryGirl.create :brewery, name:"Koff"
    user2 = FactoryGirl.create :user2
    FactoryGirl.create :beer, name:"iso 3", brewery:brewery
    FactoryGirl.create :beer, name:"Karhu", brewery:brewery
    FactoryGirl.create :rating, score: 20, beer_id: 1, user_id: 2
    FactoryGirl.create :rating, score: 30, beer_id: 2, user_id: 2
    FactoryGirl.create :rating, score: 18, beer_id: 2, user_id: 1
    sign_in(username:"Seppo", password:"Foobar2")
    visit user_path(user2)
    expect(page).to have_content "Has made 2 ratings"
  end

  it "can delete his/her ratings" do
    user2 = FactoryGirl.create :user2
    brewery = FactoryGirl.create :brewery
    FactoryGirl.create :beer, name:"iso 3", brewery:brewery
    FactoryGirl.create :beer, name:"Karhu", brewery:brewery
    FactoryGirl.create :rating, score: 20, beer_id: 1, user_id: 2
    FactoryGirl.create :rating, score: 30, beer_id: 2, user_id: 2
    sign_in(username:"Seppo", password:"Foobar2")
    visit user_path(user2)
    expect{
    page.all('a', text:'delete')[1].click
    }.to change{Rating.count}.by(-1)
  end
end