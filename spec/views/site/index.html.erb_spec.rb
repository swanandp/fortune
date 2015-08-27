require "rails_helper"

RSpec.describe "site/index.html.erb", type: :view do
  it "displays the header text" do
    render

    expect(rendered).to include("Fortune. Subscribed.")
  end
end
