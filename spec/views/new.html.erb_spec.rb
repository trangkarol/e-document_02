require "rails_helper"

describe "documents/new" do
  it "displays form new the documents" do
    # login_user
    assign(:document, Document.new)

    render :template => "documents/new.html.erb"

    # expect(rendered).to match /slicer/
  end
end

RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :view
end