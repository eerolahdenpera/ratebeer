require 'rails_helper'

include Helpers

describe "Beers" do
  before :each do
    FactoryGirl.create :user2
    FactoryGirl.create :brewery, name: "Schlenkerla"
    FactoryGirl.create :style
    sign_in(username:"Seppo", password:"Foobar2")
    visit new_beer_path
  end

  it "can be added if valid name given" do
    fill_in('beer_name', with:'Urbock')
    expect{
      click_button('Create Beer')
    }.to change{Beer.count}.by(1)
  end

  it "can not be added if without name" do
    expect{
      click_button('Create Beer')
    }.to change{Beer.count}.by(0)
    expect(page).to have_content "Name can't be blank"
  end
end