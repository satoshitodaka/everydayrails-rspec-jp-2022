require 'rails_helper'

RSpec.describe 'SignUp', type: :system do
  include ActiveJob::TestHelper

  # ユーザーはサインアップに成功する
  scenario 'user successfully signs up' do
    visit root_path
    click_link 'Sign up'

    perform_enqueued_jobs do
      expect {
        fill_in 'First name', with: 'First'
        fill_in 'Last name', with: 'User'
        fill_in 'Email', with: 'test@example.com'
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
        click_button 'Sign up'
      }.to change(User, :count).by(1)

      expect(page).to have_content 'Welcome! You have signed up successfully.'
      expect(current_path).to eq root_path
      expect(page).to have_content 'First User'
    end

    mail = ActionMailer::Base.deliveries.last

    aggregate_failures do
      expect(mail.to).to eq ['test@example.com']
      expect(mail.from).to eq ['support@example.com']
      expect(mail.subject).to eq 'Welcome to Projects!'
      expect(mail.body).to match 'Hello First,'
      expect(mail.body).to match 'test@example.com'
    end
  end

end
