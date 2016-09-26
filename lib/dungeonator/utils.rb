
module Utils

  def self.centered_x(string)
    (Txcols / 2 - string.length / 2) * Charw
    # (Txcols - string.length) * Charw / 2
  end

end
