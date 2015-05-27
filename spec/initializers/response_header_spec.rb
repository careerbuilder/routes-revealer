require 'spec_helper'

module ActionController
  describe Base, type: :controller do
    context 'on application init' do
      it { expect(ActionController::Base).to receive(:after_filter).with(:add_app_name_headers) }
      after { load 'config/initializers/response_header.rb' }

      describe '#add_app_name_headers' do
        subject { controller.send :add_app_name_headers }

        before do
          allow(Rails).to receive_message_chain(:application, :class, :parent_name).and_return('MyApp')
          allow_any_instance_of(ActionController::Base).to receive(:response).and_return(double('response', headers: {}))
        end

        it do
          binding.pry
          subject
          expect(response.headers['ApplicationName']).to eq 'MyApp'
        end

      end
    end
  end
end

