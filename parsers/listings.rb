nokogiri = Nokogiri.HTML(content)

products = nokogiri.css('#searchProductResult li')
products.each do |product|
  href = product.at_css('a.product-title-link')['href']
  url = URI.join('https://www.walmart.com', href).to_s
  pages << {
      url: url,
      page_type: 'products',
      fetch_type: 'browser',
      vars: {}
    }
end