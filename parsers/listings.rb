nokogiri = Nokogiri.HTML(content)

products = nokogiri.css('li.Grid-col')
products.each do |product|
    href = product.at_css('a.product-title-link')
    if href
        url = href['href'] ? "https://www.walmart.com#{href['href']}" : nil
        pages << {
            url: url,
            page_type: 'products',
            fetch_type: 'browser',
            method: "GET",
            force_fetch: true
            #vars: {}
        }
    end
end