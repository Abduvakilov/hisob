class Currency < ApplicationRecord

  validates_presence_of :code, :name

  def to_s
    self.code
  end
end
