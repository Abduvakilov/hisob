# == Schema Information
#
# Table name: currencies
#
#  id                :integer          not null, primary key
#  code              :string
#  name              :string
#  precision_to_show :integer          default(2)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Currency < ApplicationRecord
  def to_s
    self.code
  end
  def to_str
    to_s
  end
end
