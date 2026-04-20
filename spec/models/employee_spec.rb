require 'rails_helper'

RSpec.describe Employee, type: :model do
  let(:employee) { build(:employee) }

  it 'is valid with valid attributes' do
    expect(employee).to be_valid
  end
end
