class Article < ActiveRecord::Base
  belongs_to :entry

  def self.upload(file)
    name =  SecureRandom.uuid.to_s + ".html"
    time = Time.new
    directory = "upload/body/"+time.year.to_s+"/"+time.month.to_s
    if !File.directory? File.expand_path(directory)
      FileUtils.mkdir_p (directory)
    end
    # create the file path
    path = File.join(directory, name)
    # write the file
    File.open(path, "wb") { |f| f.write(file.read) }
  end

end
