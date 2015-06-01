require 'spec_helper'

module ActionController
  describe Base do
    let(:controller) { described_class.new }
    let(:mock_response) { double('response', headers: {}) }

    describe '#add_app_name_headers' do
      before do
        allow_any_instance_of(ActionController::Base).
          to receive(:response).
          and_return(mock_response)
      end

      it do
        controller.add_app_name_headers
        expect(mock_response.headers['ApplicationName']).to eq 'Dummy'
      end
    end
  end
end
