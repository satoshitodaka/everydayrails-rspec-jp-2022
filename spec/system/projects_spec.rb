require 'rails_helper'

RSpec.describe 'Projects', type: :system do
  # ユーザーは新しいプロジェクトを作成する
  scenario 'user creates a new project' do
    user = FactoryBot.create(:user)
    sign_in_as user

    expect {
      click_link 'New Project'
      fill_in 'Name', with: 'Test Project'
      fill_in 'Description', with: 'Trying out Capybara'
      click_button 'Create Project'

      expect(page).to have_content 'Project was successfully created'
      expect(page).to have_content 'Test Project'
      expect(page).to have_content 'Trying out Capybara'
    }.to change(user.projects, :count).by(1)
  end
end
