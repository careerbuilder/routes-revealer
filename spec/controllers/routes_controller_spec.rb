require 'spec_helper'

describe RoutesRevealer::RoutesController do
  describe '#index' do

    let(:good_defaults) { { controller: true } }
    let(:bad_defaults) { { controller: nil } }
    let(:good_route1) { double("good_route1", path: double("path", spec: "/good/route1(.:format)"), defaults: good_defaults) }
    let(:good_route2) { double("good_route2", path: double("path", spec: "/good/route2(.:format)"), defaults: good_defaults) }
    let(:bad_route1) { double("bad_route1", path: double("path", spec: "/404(.:format)"), defaults: good_defaults) }
    let(:bad_route2) { double("bad_route2", path: double("path", spec: "/rails(.:format)"), defaults: good_defaults) }
    let(:bad_route3) { double("bad_route3", path: double("path", spec: "/routes(.:format)"), defaults: good_defaults) }
    let(:bad_route4) { double("bad_route4", path: double("path", spec: "/(.:format)"), defaults: good_defaults) }
    let(:bad_route5) { double("bad_route5", path: double("path", spec: "/asdf(.:format)"), defaults: bad_defaults) }
    let(:routes) { [good_route1, good_route2, bad_route1, bad_route2, bad_route3, bad_route4] }

    before do
      allow(Rails).to receive_message_chain(:application, :routes, :routes).and_return(routes)
      allow(Rails).to receive_message_chain(:application, :class, :config, :assets, :prefix).and_return("/assets")
      get :index
    end

    it { expect(response.status).to eq 200 }
    it { expect(JSON.parse(response.body).length).to eq 3 }
    it { expect(JSON.parse(response.body)[0]).to eq "/good/route1" }
    it { expect(JSON.parse(response.body)[1]).to eq "/good/route2" }
    it { expect(JSON.parse(response.body)[2]).to eq "/assets" }

  end
end
