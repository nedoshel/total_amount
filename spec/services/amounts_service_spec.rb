require 'rails_helper'

RSpec.shared_examples 'does not create a amount' do |parameter|
  it 'returns total_amount and does not create a amount' do
    expect(Amount).not_to receive(:new)
    expect(StorageService).not_to receive(:new)
    expect(Storage).to receive(:total_amount).and_return(OpenStruct.new(value: 123))

    expect(subject).to be(123)
    expect(Amount.count).to be(0)
  end
end

describe AmountsService do
  describe '#perform' do
    subject { described_class.new(value: value, token: token).perform }

    let(:value) { 123 }
    let(:token) { 'qwrerty123' }

    context 'params' do
      context 'when value is empty' do
        let(:value) { '' }

        context 'and token is empty' do
          let(:token) { '' }

          it_behaves_like 'does not create a amount'
        end

        context 'and token exists' do
          it_behaves_like 'does not create a amount'
        end
      end

      context 'when value exists' do
        context 'and token is empty' do
          let(:token) { '' }

          it_behaves_like 'does not create a amount'
        end
      end

      context 'and token exists' do
        it 'triggers storage service and creates amount' do
          expect(StorageService).to receive(:new).and_call_original
          expect_any_instance_of(StorageService).to receive(:increment_total_amount)
          expect(Storage).to receive(:total_amount).and_return(OpenStruct.new(value: 123))

          expect(subject).to be(123)
          expect(Amount.count).to be(1)
        end
      end
    end

    context 'when token duplicates' do
      before do
        Amount.create(token: token, value: 111)
      end

      it 'returns total_amount and does not create a amount' do
        expect(StorageService).not_to receive(:new)
        expect(Amount).not_to receive(:create)
        expect(Amount).to receive(:exists?).and_call_original
        expect(Storage).to receive(:total_amount).and_return(OpenStruct.new(value: 123))

        expect(subject).to be(123)
        expect(Amount.count).to be(1)
      end
    end
  end
end
