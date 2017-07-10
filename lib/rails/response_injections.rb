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
module ActionController
  class Base
    after_action :add_app_name_headers

    def add_app_name_headers
      app_name = Rails.application.class.parent_name
      response.headers['ApplicationName'] = app_name
    end
  end
end
