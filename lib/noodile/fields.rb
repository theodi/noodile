class Fields < Array
  attr_writer :path

  def initialize line
    @path = nil

    line.each do |bit|
      self << bit
    end
  end

  def without_postcodes
    a = Array.new self

    a.delete_if {
        |field|
      field.match /postcode/ or field.match /incode/
    }

    a
  end

  def write purge_postcodes = true
    CSV.open(@path, "wb", { :force_quotes => false }) do |csv|
      if purge_postcodes
        csv << self.without_postcodes
      else
        csv << self
      end
    end
  end
end