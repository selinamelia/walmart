nokogiri = Nokogiri.HTML(content)
click_captha_code = " 
  await sleep(3000);
  if ( (await page.$('div#js-global-footer-wrapper form#hf-email-signup-form')) == null){
    await sleep(5412);
    if ( (await page.$('iframe[style*=\"display: block\"]')) !== null) {
      // do things with its content
      await page.hover('iframe[style*=\"display: block\"]'); await sleep(1428); 
      // click hold and wait loading new page
      await Promise.all([
        page.waitForNavigation(),
        page.click('iframe[style*=\"display: block\"]', {delay: 9547}),
      ]);
    };
  };
  await page.setPageLimitLoadingTime(3000);
"


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
            driver: {
                code: click_captha_code
            }
        }
    end
end