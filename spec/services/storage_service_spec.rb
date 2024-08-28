require 'rails_helper'

describe StorageService do
  describe '#increment_total_amount' do
    subject { described_class.new(value: value).increment_total_amount }

    let(:value) { 123 }

    context 'value' do
      context 'when blank' do
        let(:value) { ' ' }

        it do
          expect { subject }.to change { Storage.count }.by(0)
        end
      end

      context 'when present' do
        it do
          expect { subject }.to change { Storage.total_amount.value }.from(nil).to(123)
        end
      end
    end
  end

  context 'multitreading' do
    let!(:threads) do
      50.times.map do
        Thread.new { described_class.new(value: 10).increment_total_amount }
      end
    end

    it 'when 50 threads' do
      expect do
        threads.each(&:join)
      end.to change { Storage.total_amount.value }.from(nil).to(500)
    end
  end
end
