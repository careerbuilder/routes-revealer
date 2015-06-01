module Rails
  module ResponseInjections 
    ActionController::Base.send :after_filter, :add_app_name_headers

    def self.add_app_name_headers
      app_name = Rails.application.class.parent_name

      response.headers['ApplicationName'] = app_name
    end
  end
end

