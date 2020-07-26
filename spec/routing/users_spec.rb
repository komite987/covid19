require 'rails_helper'


describe "Users routes" do

  it "Should routes to users index" do
    expect(get: "/users").to route_to(
      controller: "users",
      action: "index"
      )
  end

  it "Should routes to users show" do
    expect(get: "/users/1").to route_to(
      controller: "users",
      action: "show",
      id: "1"
      )
  end

  it "Should routes to users edit" do
    expect(get: "/users/1/edit").to route_to(
      controller: "users",
      action: "edit",
      id: "1"
      )
  end

  it "Should routes to users update" do
    expect(patch: "/users/1").to route_to(
      controller: "users",
      action: "update",
      id: "1"
      )
  end

  it "Should routes to users delete" do
    expect(delete: "/users/1").to route_to(
      controller: "users",
      action: "destroy",
      id: "1"
      )
  end



end
