FactoryBot.define do
  factory :project do
    sequence(:name) { |n| "Project#{n}" }
    description { 'A test project' }
    due_on { 1.week.from_now }
    association :owner

    # メモ付きのプロジェクト
    trait :with_notes do
      after(:create) { |project| create_list(:note, 5, project: project)}
    end
  end

  # 昨日が締め切りのプロジェクト
  factory :project_due_yesterday, class: Project do
    sequence(:name) { |n| "Test project#{n}" }
    description { 'Sample project for testing' }
    due_on { 1.day.ago }
    association :owner
  end

  # 今日が締め切りのプロジェクト
  factory :project_due_today, class: Project do
    sequence(:name) { |n| "Test project#{n}" }
    description { 'Sample project for testing' }
    due_on { Date.current.in_time_zone }
    association :owner
  end

  # 明日が締め切りのプロジェクト
  factory :project_due_tommrow, class: Project do
    sequence(:name) { |n| "Test project#{n}" }
    description { 'Sample project for testing' }
    due_on { 1.day.from_now }
    association :owner
  end
end
