require 'rails_helper'


describe "Search routes" do

  it "Should routes to searches home" do
    expect(get: "/").to route_to(
      controller: "searches",
      action: "home"
      )
  end

  it "Should routes to searches new" do
    expect(get: "/search").to route_to(
      controller: "searches",
      action: "new"
      )
  end


  it "Should routes to searches show" do
    expect(post: "/search").to route_to(
      controller: "searches",
      action: "show"
      )
  end


end
