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
require 'spec_helper'

describe RoutesRevealer::RoutesController do
  describe '#index' do

    let(:this_engine_string) { "This::Engine" }
    let(:that_engine_string) { "That::Engine" }

    let(:route1) { double("route1", path: "/1", verb: "GET", reqs: "controller#1") }
    let(:route2) { double("route2", path: "/2", verb: "POST", reqs: "controller#2") }
    let(:route3) { double("route3", path: "/3", verb: "PUT", reqs: "controller#3") }
    let(:route4) { double("route4", path: "/4", verb: "DELETE", reqs: "controller#4") }
    let(:route5) { double("route5", path: "/", verb: "GET", reqs: this_engine_string) }
    let(:route6) { double("route6", path: "/that", verb: "GET", reqs: that_engine_string) }
    let(:bad_route7) { double("bad_route7", path: "/routes", verb: "HEAD", reqs: "controller#route7") }
    let(:bad_route8) { double("bad_route7", path: "/rails", verb: "TRACE", reqs: "controller#route8") }

    let(:this_route1) { double("this_route1", path: "/t1", verb: "RAMBO", reqs: "this_controller#1") }
    let(:this_route2) { double("this_route2", path: "/t2", verb: "ALWAYS", reqs: "this_controller#2") }
    let(:that_route1) { double("that_route1", path: "/1", verb: "SHOOTS", reqs: "that_controller#1") }
    let(:that_route2) { double("that_route2", path: "/2", verb: "WALNUTS", reqs: "that_controller#2") }

    let(:routes) { [route1, route2, route3, route4, route5, route6, bad_route7, bad_route8] }
    let(:this_routes) { [this_route1, this_route2] }
    let(:that_routes) { [that_route1, that_route2] }

    let(:this_engine) { double("this_engine", routes: double("routes", routes: this_routes))}
    let(:that_engine) { double("that_engine", routes: double("routes", routes: that_routes))}

    let(:route_wrapper) { ActionDispatch::Routing::RouteWrapper }

    before do
      allow(Rails).to receive_message_chain(:application, :routes, :routes).and_return(routes)
      allow(Rails).to receive_message_chain(:application, :class, :config, :assets, :prefix).and_return("/assets")

      allow(Module).to receive(:const_get).with(this_engine_string).and_return(this_engine)
      allow(Module).to receive(:const_get).with(that_engine_string).and_return(that_engine)

      allow(route_wrapper).to receive(:new).with(route1).and_return(route1)
      allow(route_wrapper).to receive(:new).with(route2).and_return(route2)
      allow(route_wrapper).to receive(:new).with(route3).and_return(route3)
      allow(route_wrapper).to receive(:new).with(route4).and_return(route4)
      allow(route_wrapper).to receive(:new).with(route5).and_return(route5)
      allow(route_wrapper).to receive(:new).with(route6).and_return(route6)
      allow(route_wrapper).to receive(:new).with(bad_route7).and_return(bad_route7)
      allow(route_wrapper).to receive(:new).with(bad_route8).and_return(bad_route8)

      allow(route_wrapper).to receive(:new).with(this_route1).and_return(this_route1)
      allow(route_wrapper).to receive(:new).with(this_route2).and_return(this_route2)

      allow(route_wrapper).to receive(:new).with(that_route1).and_return(that_route1)
      allow(route_wrapper).to receive(:new).with(that_route2).and_return(that_route2)

      get :index
    end

    it { expect(response.status).to eq 200 }
    it { expect(JSON.parse(response.body).length).to eq 9 }
    it { expect(JSON.parse(response.body)[0]).to eq "/1" }
    it { expect(JSON.parse(response.body)[1]).to eq "/2" }
    it { expect(JSON.parse(response.body)[2]).to eq "/3" }
    it { expect(JSON.parse(response.body)[3]).to eq "/4" }
    it { expect(JSON.parse(response.body)[4]).to eq "/assets" }
    it { expect(JSON.parse(response.body)[5]).to eq "/t1" }
    it { expect(JSON.parse(response.body)[6]).to eq "/t2" }
    it { expect(JSON.parse(response.body)[7]).to eq "/that/1" }
    it { expect(JSON.parse(response.body)[8]).to eq "/that/2" }

  end
end
