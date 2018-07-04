class Currency < ApplicationRecord
  def to_str
    self.code
  end
end
