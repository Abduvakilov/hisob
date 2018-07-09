class TransactionsGrid

  include Datagrid

  scope do
    Transaction.order(:created_at)
  end

  # filter :rating, :enum, :select => 0..10
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
  column :type
  column :account
  column :counter_party
  column :amount_formatted
  column :date

end