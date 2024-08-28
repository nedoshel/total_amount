require 'rails_helper'

describe AmountsController do
  describe 'POST #create' do
    subject { post :create, params: params }

    let(:params) { { value: 1, token: 'aaaa123', any: 2 } }

    it 'calls AmountsService' do
      expect(AmountsService).to receive(:new).with(value: '1', token: 'aaaa123').and_call_original
      expect_any_instance_of(AmountsService).to receive(:perform).and_return(10)

      subject

      expect(response.parsed_body).to eq({ 'total_amount' => 10 })
    end
  end
end
