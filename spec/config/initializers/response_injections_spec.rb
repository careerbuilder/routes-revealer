# Copyright 2017 CareerBuilder, LLC
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and limitations under the License.
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
