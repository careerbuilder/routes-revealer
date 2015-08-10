module RoutesRevealer
  class RoutesController < ApplicationController
    skip_filter(*_process_action_callbacks.map(&:filter))

    def index
      output = []
      Rails.application.routes.routes.each do |r|
        route_string = r.path.spec.to_s.sub('(.:format)', '')
        unless ignore_route?(route_string)
          output.push route_string if r.defaults[:controller]
        end
      end

      output.push Rails.application.class.config.assets.prefix

      render json: output
    end

    private

    def ignore_route?(route_string)
      route_string =~ /(\/[0-9]{3})|(^\/routes)|(^\/rails)/
    end
  end
end
