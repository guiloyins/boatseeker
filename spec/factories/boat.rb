FactoryBot.define do
  factory :boat, class: Boat do
    model { 'Zxa' }
    length { 5 }
    latitude { '103.2210023' }
    longitude { '42.3120905' }
  end
end