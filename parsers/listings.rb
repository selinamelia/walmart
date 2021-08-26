nokogiri = Nokogiri.HTML(content)

products = nokogiri.css('li.Grid-col')
cookies = page['response_cookie']

click_captha_code = " 
    await sleep(3000);
    if ( (await page.$('div#js-global-footer-wrapper form#hf-email-signup-form')) == null ) {
        await sleep(5412);
        if ( (await page.$('iframe[style*=\"display: block\"]')) !== null) {
            // do things with its content
            await page.hover('iframe[style*=\"display: block\"]'); await sleep(1428); 
            // click hold and wait loading new page
            await Promise.all([
                page.waitForNavigation({timeout: 30000}),
                page.click('iframe[style*=\"display: block\"]', {delay: 9547}),
            ]);          
        };
    };
"

products.each do |i|
    link_node = i.at_css('.product-title-link')
    url = link_node['href'] ? "https://www.walmart.com#{link_node['href']}" : nil

    if url =~ /\Ahttps?:\/\//i
        pages << {
            url: url,
            page_type: "products",
            fetch_type: "browser",
            method: "GET",
            force_fetch: true,
            headers: { 
            "User-Agent": "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36"},
            driver: {
                code: click_captha_code
            }
        }
    end
end

# pagination_links = nokogiri.css('ul.paginator-list li a')
# pagination_links.each do |link|
#   url = URI.join('https://www.walmart.com', link['href']).to_s
#   pages << {
#       url: url,
#       page_type: 'listings',
#       fetch_type: 'browser',
#       vars: {}
#     }
# end