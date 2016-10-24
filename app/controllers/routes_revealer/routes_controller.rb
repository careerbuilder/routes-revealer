# Copyright 2015 CareerBuilder, LLC
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and limitations under the License.
module RoutesRevealer
  class RoutesController < ApplicationController
    skip_filter(*_process_action_callbacks.map(&:filter))

    def index
      output = []
      output += [asset_route]
      output += public_folder
      output += map_routes(Rails.application.routes.routes).flatten
      output.compact!.uniq!
      output.sort! if output
      render json: output
    end

    private

    def ignore_route?(route_string)
      route_string =~ /(\/[0-9]{3})|(^\/routes)|(^\/rails)/
    end

    def asset_route
      Rails.application.class.config.assets.prefix
    end

    def public_folder
      files = Dir.glob('public/**/*')
      files.map! do |file|
        file[6..-1]
      end
      files.reject! do |file|
        file.starts_with?(asset_route) || file == '/system'
      end
      files
    end

    def map_routes(routes, prepend='')
      prepend = '' if prepend == '/'
      route_hash_array(routes).map do |route_hash|
        if route_hash[:reqs].to_s.include?("::Engine")
          map_routes(Module.const_get(route_hash[:reqs].to_s).routes.routes, route_hash[:path])
        else
          "#{prepend}#{route_hash[:path]}" unless ignore_route?(route_hash[:path])
        end
      end
    end

    def route_hash_array(routes)
      routes.map do |route|
        ActionDispatch::Routing::RouteWrapper.new(route)
      end.map do |route|
        {
          path: route.path.sub('(.:format)', ''),
          verb: route.verb,
          reqs: route.reqs
        }
      end
    end
  end
end
