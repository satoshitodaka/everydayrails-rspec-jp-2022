FactoryBot.define do
  factory :note do
    message { 'This is a sample note.'}
    association :project
    user { project.owner }
  end
end
