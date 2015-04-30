module ControllerHelpers
  extend ActiveSupport::Concern

  included do
    routes { RoutesRevealer::Engine.routes }
  end
end
