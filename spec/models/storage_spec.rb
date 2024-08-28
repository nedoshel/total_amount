require 'rails_helper'

RSpec.describe Storage, type: :model do
  describe '#total_amount' do
    subject { described_class.total_amount }

    it 'calls find_or_initialize_by' do
      expect(described_class).to receive(:find_or_initialize_by).with(name: :total_amount)

      subject
    end
  end
end
