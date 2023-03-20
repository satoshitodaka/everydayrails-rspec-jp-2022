require 'rails_helper'

RSpec.describe Project, type: :model do
  before do
    @user = User.create(
      first_name: 'Joe',
      last_name: 'Tester',
      email: 'tester@example.com',
      password: 'password'
    )

    @user.projects.create(
      name: 'Test Project'
    )
  end

  # たくさんのメモが付いていること
  it "can have many notes" do
    project = FactoryBot.create(:project, :with_notes)
    expect(project.notes.length).to eq 5 
  end

  # プロジェクト名がなければ無効な状態であること
  it "is invalid without a name" do
    project = @user.projects.new(name: nil)
    project.valid?
    expect(project.errors[:name]).to include("can't be blank")
  end

  # ユーザー単位では重複したプロジェクト名を許可しないこと
  it "does not allow duplicate project names per user" do
    new_project = @user.projects.build(
      name: 'Test Project'
    )

    new_project.valid?
    expect(new_project.errors[:name]).to include('has already been taken')
  end

  # 二人のユーザーが同じ名前を使うことは許可すること
  it "allows two users to share a project name" do
    other_user = User.create(
      first_name: 'Jane',
      last_name: 'Tester',
      email: 'janetester@example.com',
      password: 'password'
    )

    other_project = other_user.projects.build(
      name: 'Test Project'
    )

    other_project.valid?
    expect(other_project).to be_valid
  end

  # 遅延ステータス
  describe"latestatus" do
    # 締切日が過ぎていれば遅延していること
    it "is late when the due date is past today" do
      project = FactoryBot.create(:project_due_yesterday)
      expect(project).to be_late
    end

    # 締切日が今日ならスケジュールどおりであること
    it "is on time when the due date is today" do
      project = FactoryBot.create(:project_due_today)
      expect(project).to_not be_late
    end

    # 締切日が明日ならスケジュールどおりであること
    it "is on time when the due date is in the future" do
      project = FactoryBot.create(:project_due_tommrow)
      expect(project).to_not be_late
    end
  end
end
