require "rails_helper"
RSpec.describe Document, type: :model do
  context "associations" do
    it {is_expected.to belong_to :owner}
    it {is_expected.to belong_to :category}
    it {is_expected.to have_many :histories}
    it {is_expected.to have_many :users}
    it {is_expected.to have_many :comments}
    it {is_expected.to have_many :favorites}
  end

  it "is invalid without a name" do
    document = FactoryGirl.build(:document, name: nil)
    expect(document.valid?).to be_falsey
    expect(document.errors[:name]).to include("can't be blank")
  end

  it "is invalid without name less than 5 characters" do
    document = FactoryGirl.build(:document, name: "abcd")
    expect(document.valid?).to be_falsey
    expect(document.errors[:name]).to include("is too short (minimum is 5 characters)")
  end

  it "is invalid without name more than 200 characters" do
    name = "a" * 201
    document = FactoryGirl.build(:document, name: name)
    expect(document.valid?).to be_falsey
    expect(document.errors[:name]).to include("is too long (maximum is 200 characters)")
  end

  it "is invalid without a description" do
    document = FactoryGirl.build(:document, description: nil)
    expect(document.valid?).to be_falsey
    expect(document.errors[:description]).to include("can't be blank", "is too short (minimum is 4 characters)")
  end

  it "is invalid without a description less than 4 characters" do
    document = FactoryGirl.build(:document, description: "abc")
    expect(document.valid?).to be_falsey
    expect(document.errors[:description]).to include("is too short (minimum is 4 characters)")
  end

  it "is invalid without a file" do
    document = FactoryGirl.build(:document, file: nil)
    expect(document.valid?).to be_falsey
    expect(document.errors[:file]).to include("can't be blank")
  end

  it "is invalid without category" do
    document = FactoryGirl.build(:document, category_id: nil)
    expect(document.valid?).to be_falsey
    expect(document.errors[:category_id]).to include("can't be blank")
  end

  it "is invalid without owner" do
    document = FactoryGirl.build(:document, user_id: nil)
    expect(document.valid?).to be_falsey
    expect(document.errors[:owner]).to include("must exist")
  end
end
