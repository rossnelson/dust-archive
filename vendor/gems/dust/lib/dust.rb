require "dust/engine"

module Dust
  def self.root
    path = File.join(Rails.root, "vendor", "gems", "dust")
    Pathname.new(path)
  end
end
