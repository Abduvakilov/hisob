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

  def to_s
    name
  end

  def price=(value)
    prices.create! price: value
  end

  def category_price(currency_id)
    Price.kept.where('date <= ?', Date.today).
      order('date desc').find_by(category_id: category_id, currency_id: currency_id).
      price if category_id?
  end

  def price(options={})
    raise ArgumentError, "At least, :price_type_id and :currency_id or :contract_id should be provided" unless (options[:price_type_id] && options[:currency_id]) || options[:contract_id]
    price_type_id = options[:price_type_id] || Contract.find(options[:contract_id]).category_id
    currency_id = options[:currency_id] || Contract.find(options[:contract_id]).currency_id
    prices.kept.where('date <= ?', Date.today).
      order('date DESC').find_by(price_type_id: price_type_id, currency_id: currency_id)&.
      price || category_price(currency_id)
  end

  def self.shown_fields
    %w[name leftover unit is_for_sale company category include_base_unit]
  end


  validates_presence_of :name, :amount

  has_many :sales_items, -> { kept }
  has_many :prices, -> { kept }
  belongs_to :unit, optional: true
  belongs_to :company, optional: true
  belongs_to :counter_party, optional: true
  belongs_to :category, optional: true


end
