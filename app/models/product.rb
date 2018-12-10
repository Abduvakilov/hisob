class Product < ApplicationRecord

  def leftover(date=Date.tomorrow)
    production = Production.joins(:production_items).kept
      .where(production_items: {product: self})
      .where('date <= ?', date)
      .sum 'production_items.amount'

    purchase = Purchase.joins(:purchase_items).kept
      .where(purchase_items: {product: self})
      .where('datetime <= ?', date)
      .sum 'purchase_items.amount'

    sale = Sale.joins(:sale_items).kept
      .where(sale_items: {product: self})
      .where('datetime <= ?', date)
      .sum 'sale_items.amount'

    production + purchase - sale
  end

  def category_price(currency_id)
    Price.kept.where('date <= ?', Date.today)
      .order('date desc')
      .find_by(product_type_id: category_id, currency_id: currency_id) if category_id?
  end

  def price_for_contract(contract_id)
    contract      = Contract.kept.find(contract_id)
    price_type_id = contract.price_type_id
    currency_id   = contract.currency_id
    prices.where('date <= ?', Date.today)
      .order('date DESC')
      .find_by(price_type_id: price_type_id, currency_id: currency_id) ||

    category_price(currency_id)
  end

  def self.shown_fields
    %w[name leftover unit is_for_sale company category include_base_unit]
  end


  validates_presence_of :name


  belongs_to :unit,          optional: true
  belongs_to :company,       optional: true
  belongs_to :counter_party, optional: true
  belongs_to :category,      optional: true

  has_many   :sales_items,   -> { kept }
  has_many   :prices,        -> { kept }
  has_one    :base_unit,     through: :unit


  def to_s
    name
  end

end
