FactoryBot.define do
  factory :boat, class: Boat do
    model { 'Zxa' }
    length { 5 }
    latitude { '42.3120905' }
    longitude { '103.2210023' }
  end
end