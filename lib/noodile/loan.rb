class Loan < Hash
  attr_writer :path

  def initialize line, fields, purge_postcodes = false
    @purge_postcodes = purge_postcodes
    @fields          = fields
    @path            = nil

    index = 0
    @fields.each do |key|
      store = true
      if @purge_postcodes
        if key.match /postcode/ or key.match /incode/
          store = false
        end
      end
      if store
        self[key] = line[index]
      end
      index = index + 1
    end
  end

  def as_array
    self.values
  end

  def write
    f = File.open @path, "a"
    f.write self.as_array.join ","
    f.write "\n"
    f.close
  end
end