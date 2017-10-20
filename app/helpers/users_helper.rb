module UsersHelper
  def upload_file files
    File.open Rails.root.join("public", "uploads", files.original_filename), "wb" do |file|
      file.write(files.read)
    end
  end
end
