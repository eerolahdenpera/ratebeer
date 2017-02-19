require 'rails_helper'
describe "Beers page" do
    before :each do
      @breweries = ["Koff", "Karjala", "Schlenkerla"]
      year = 1896
      @breweries.each do |brewery_name|
        FactoryGirl.create(:brewery, name: brewery_name, year: year += 1)
      end
      FactoryGirl.create :user2
      sign_in(username:"Seppo", password:"Foobar2")
      visit new_beer_path
    end
    it "Try to create beer without name" do

      fill_in('beer_name', with:'')
      click_button('Create Beer')
      expect(page).to have_content "Name can't be blank"
    end
    it "Can create beer with name" do
      fill_in('beer_name', with:'Kalja')

      expect{
        click_button('Create Beer')
      }.to change{Beer.count}.by(1)
    end
end
