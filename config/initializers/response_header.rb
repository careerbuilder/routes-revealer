module ActionController
  class Base
    after_filter :add_app_name_headers

    def add_app_name_headers
      app_name = Rails.application.class.parent_name

      response.headers['ApplicationName'] = app_name
    end
  end
end

