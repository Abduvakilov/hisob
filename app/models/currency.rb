class Currency < ApplicationRecord
  def to_s
    self.code
  end
  def to_str
    to_s
  end
end
