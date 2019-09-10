require 'rails_helper'

RSpec.describe Boat, type: :model do
  describe 'validations' do
    %i[model length lonlat].each do |params|
      it { is_expected.to validate_presence_of(params) }
    end

    it { is_expected.to validate_numericality_of(:length).is_greater_than(0) }
  end
end
