require 'aruba/cucumber'

Before do
  @dirs = ['.']
  Dir.mkdir("outputs") unless Dir.exists?("outputs")
  Dir.entries("outputs").each do |entry|
    if not ['.', '..'].include? entry then
      File.unlink "outputs/%s" % [
          entry
      ]
    end
  end
end

After do
  File.delete "sample.csv"
end