Spree::Sample.load_sample('tax_categories')
Spree::Sample.load_sample('shipping_categories')

clothing = Spree::TaxCategory.find_by!(name: 'Clothing')

products = [
  {
    name: 'Avishai Ish-Shalom​',
    tax_category: clothing,
    price: 15.99,
    eur_price: 14
  },
  {
    name: 'Yaron Amir',
    tax_category: clothing,
    price: 22.99,
    eur_price: 19
  },
  {
    name: 'Andrei Burd',
    tax_category: clothing,
    price: 19.99,
    eur_price: 16
  },
  {
    name: 'Arie Belenki',
    tax_category: clothing,
    price: 19.99,
    eur_price: 16

  },
  {
    name: 'Ariel Moskovich​',
    tax_category: clothing,
    price: 19.99,
    eur_price: 16
  },
  {
    name: 'Eyal Stoler',
    tax_category: clothing,
    price: 19.99,
    eur_price: 16
  },
  {
    name: 'Gai Radzi',
    tax_category: clothing,
    price: 19.99,
    eur_price: 16
  },
  {
    name: 'Lev Andelman',
    tax_category: clothing,
    price: 19.99,
    eur_price: 16
  },
  {
    name: 'Tom Sender',
    tax_category: clothing,
    price: 19.99,
    eur_price: 16
  },
  {
    name: 'Omri Niv',
    tax_category: clothing,
    price: 19.99,
    eur_price: 16
  },
  {
    name: 'Mickey Shaul',
    tax_category: clothing,
    price: 15.99,
    eur_price: 14
  },
  {
    name: 'logo',
    tax_category: clothing,
    price: 22.99,
    eur_price: 19
  },
  {
    name: 'Ruby on Rails Mug',
    price: 13.99,
    eur_price: 12
  },
  {
    name: 'Ruby on Rails Stein',
    price: 16.99,
    eur_price: 14
  },
  {
    name: 'Spree Stein',
    price: 16.99,
    eur_price: 14
  },
  {
    name: 'Spree Mug',
    price: 13.99,
    eur_price: 12
  }
]

default_shipping_category = Spree::ShippingCategory.find_by!(name: 'Default')

products.each do |product_attrs|
  Spree::Config[:currency] = 'USD'
  eur_price = product_attrs.delete(:eur_price)

  new_product = Spree::Product.where(name: product_attrs[:name],
                                     tax_category: product_attrs[:tax_category]).first_or_create! do |product|
    product.price = product_attrs[:price]
    product.description = FFaker::Lorem.paragraph
    product.available_on = Time.zone.now
    product.shipping_category = default_shipping_category
  end

  next unless new_product

  Spree::Config[:currency] = 'EUR'
  new_product.reload
  new_product.price = eur_price
  new_product.save
end

Spree::Config[:currency] = 'USD'
