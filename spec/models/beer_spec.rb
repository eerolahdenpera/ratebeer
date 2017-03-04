require 'rails_helper'

RSpec.describe Beer, type: :model do
    it "will be fine with name and style" do
      beer = FactoryGirl.create(:beer)

      expect(beer).to be_valid
      expect(Beer.count).to eq(1)
    end
    it "has to have name" do
      beer = Beer.create name: ""

     expect(beer).not_to be_valid
      expect(Beer.count).to eq(0)
    end
    it "need to have style to survive" do
      beer = Beer.create name: "NoStyle"

      expect(beer).not_to be_valid
      expect(Beer.count).to eq(0)
    end

end
