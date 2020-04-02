require 'rails_helper'

feature 'An admin can delete a tutorial' do
  scenario 'and it should no longer exist' do
    admin = create(:admin)
    create_list(:tutorial, 2)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit '/admin/dashboard'

    expect(page).to have_css('.admin-tutorial-card', count: 2)

    within(first('.admin-tutorial-card')) do
      click_button 'Delete'
    end

    expect(page).to have_css('.admin-tutorial-card', count: 1)
  end

  it 'videos associated with tutorials are also deleted when deleting tutorials' do
    tutorial_1 = create(:tutorial)
    video_1 = create(:video, tutorial_id: tutorial_1.id)
    video_2 = create(:video, tutorial_id: tutorial_1.id)

    tutorial_2 = create(:tutorial)
    video_3 = create(:video, tutorial_id: tutorial_2.id)
    admin = create(:admin)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_dashboard_path

    within(first('.admin-tutorial-card')) do
      click_button 'Delete'
    end

    expect { Video.find(video_1.id) }.to raise_error(ActiveRecord::RecordNotFound)
    expect { Video.find(video_2.id) }.to raise_error(ActiveRecord::RecordNotFound)
    expect(Video.find(video_3.id)).to eq(video_3)
  end
end
