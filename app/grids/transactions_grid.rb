class TransactionsGrid

  include Datagrid

  scope do
    Transaction.order(:created_at)
  end

  filter :in_out_type, :enum, :select => Transaction.types
  # filter :title, :header => "Title (contains)" do |value|
  #   where(:title => /#{Regexp.escape(value)}/i)
  # end
  # filter :author, :header => "Author (regexp)" do |value|
  #   begin
  #     where(:author => Regexp.compile(value))
  #   rescue RegexpError
  #     where
  #   end
  # end
  #
  # filter :condition, :dynamic, :header => "Dynamic condition"
  column :in_out_type
  column :account
  column :counter_party
  column :amount_formatted
  column :date
  column :notes
  column :coefficient

end