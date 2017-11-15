require "rails_helper"

describe "documents/new" do
  it "displays form new the documents" do
    login_user
    assign(:document, Document.new)
    render
     expect(rendered).to include(I18n.t("document.name"))
     expect(rendered).to include(I18n.t("document.file"))
     expect(rendered).to include(I18n.t("document.image"))
     expect(rendered).to include(I18n.t("category.name"))
     expect(rendered).to include(I18n.t("document.description"))
  end
end

RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :view
end
