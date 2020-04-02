require 'rails_helper'

describe 'Admin can create tutorial' do
  describe 'As an admin' do
    before(:each) do
      @admin = create(:admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    end

    it 'I can create a new tutorial' do
      visit admin_dashboard_path

      expect(page).to_not have_content("Mod 4")

      click_on 'New Tutorial'

      fill_in "tutorial_title", with: "Mod 4"
      fill_in "tutorial_description", with: "Real deal content right here."
      fill_in "tutorial_thumbnail", with: "https://upload.wikimedia.org/wikipedia/commons/4/41/Sunflower_from_Silesia2.jpg"
      click_on "Save"

      tutorial = Tutorial.last
      expect(current_path).to eq("/tutorials/#{tutorial.id}")
      expect(page).to have_content('Successfully created tutorial.')

      visit admin_dashboard_path

      expect(page).to have_content(tutorial.title)
    end
  end
end
