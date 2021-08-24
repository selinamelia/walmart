nokogiri = Nokogiri.HTML(content)

products = nokogiri.css('div.search-result-product-title')
products.each do |product|
    href = product.at_css('a.product-title-link')
    if href
        url = URI.join('https://www.walmart.com', href['href'])
        pages << {
            url: url,
            page_type: 'products',
            fetch_type: 'browser',
            #vars: {}
        }
    end
end