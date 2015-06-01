require 'spec_helper'

module Rails
  describe ResponseInjections do
    let(:response) { double('response', headers: {}) }

    before do
      allow(Rails::ResponseInjections).to receive(:response).and_return(response)
    end

    it do
       expect(ActionController::Base).to receive(:send).with(:after_filter, :add_app_name_headers)
       load('lib/rails/response_injections.rb')
    end

    it do
      Rails::ResponseInjections.add_app_name_headers
      expect(response.headers['ApplicationName']).to eq 'Dummy'
    end

  end
end

