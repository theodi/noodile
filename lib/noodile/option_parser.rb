require 'optparse'
require 'ostruct'

class NoodileOptionParser
  def self.parse(args)
    options                 = OpenStruct.new
    options.purge_postcodes = true
    options.split_by        = nil
    options.progress        = false
    options.zip             = false
    options.output_dir      = "outputs"

    opt_parser = OptionParser.new do |opts|
      opts.banner = "Usage: processor.rb [options]"

      opts.separator ""
      opts.separator "Specific options:"

      opts.on("-p", "--[no-]purge-postcodes", "Remove postcodes from output files") do |purge|
        options.purge_postcodes = purge
      end

      opts.on("-s", "--split-by [FIELD]", "One output file per field FIELD") do |field|
        options.split_by = field
      end

      opts.on("-g", "--progress", "Display progress") do |progress|
        options.progress = progress
      end

      opts.on("-o", "--output-dir [DIR]", "Output to dir DIR") do |dir|
        options.output_dir = dir
      end

      opts.on("-z", "--zip", "Zip output files") do |zip|
        options.zip = zip
      end

      opts.separator ""
      opts.separator "Common options:"

      opts.on_tail("-h", "--help", "Show this message") do
        puts opts
        exit
      end
    end

    opt_parser.parse!(args)
    options
  end
end

