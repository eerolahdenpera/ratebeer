require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
        [ Place.new( name:"Oljenkorsi", id: 1 ) ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end
  it "more places found" do
    allow(BeermappingApi).to receive(:places_in).with("mattilanpuisto").and_return(
        [ Place.new( name:"Hillomunkki", id: 1 ),
          Place.new( name:"Keskuskatu", id: 2 ),
          Place.new( name: "Katukunkatu", id: 3)]
    )


    visit places_path
    fill_in('city', with: 'mattilanpuisto')
    click_button "Search"
    expect(page).to have_content "Hillomunkki"
    expect(page).to have_content "Keskuskatu"
    expect(page).to have_content "Katukunkatu"

  end
  it "no places found" do
    allow(BeermappingApi).to receive(:places_in).with("korpi").and_return([])

    visit places_path
    fill_in('city', with: 'korpi')
    click_button "Search"
    expect(page).to have_content "No locations in korpi"
  end
end