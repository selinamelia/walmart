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

# pagination_links = nokogiri.css('ul.paginator-list > li.active > a.active')
# pagination_links.each do |link|
#   url = URI.join('https://www.walmart.com', link['href']).to_s
#   pages << {
#       url: url,
#       page_type: 'listings',
#       fetch_type: 'browser',
#       vars: {}
#     }
# end