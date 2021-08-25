nokogiri = Nokogiri.HTML(content)

# click_captha_code = " 
# await sleep(3000);
# if ( (await page.$('div#js-global-footer-wrapper form#hf-email-signup-form')) == null ){
#   await sleep(5412);
#   if ( (await page.$('div#px-captcha iframe[style*=\"display: block\"]')) !== null ) {
#     // hover to the captha validation and sleep a bit
#     await page.hover('iframe[style*=\"display: block\"]'); 
#     await sleep(1428); 
#     // click hold and wait loading new page
#     await Promise.all([
#       page.waitForNavigation(),
#       page.click('iframe[style*=\"display: block\"]', {delay: 9547}),
#     ]);          
#   };
# };
# "
# pages << {
#     fetch_type: "browser",
#     method: "GET",
#     force_fetch: true,
#     headers: { 
#     "User-Agent": "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36"},
#     driver: {
#         code: click_captha_code
#     }
# }
# initialize an empty hash
product = {}

#extract title
product['title'] = nokogiri.at_css('.prod-ProductTitle').text

#extract current price
current_price = nokogiri.at_css('span#price').attr('content').to_f
if current_price
    product['price'] = nokogiri.at_css('span.visuallyhidden').text
end
 
#extract original price
# original_price_div = nokogiri.at_css('.price-old')
# original_price = original_price_div ? original_price_div.text.strip.gsub('$','').to_f : nil
# product['original_price'] = original_price == 0.0 ? nil : original_price

#extract rating
# rating = nokogiri.at_css('span.hiddenStarLabel .seo-avg-rating').text.strip.to_f
# product['rating'] = rating == 0 ? nil : rating

#extract number of reviews
review_text = nokogiri.at_css('span.stars-reviews-count-node').text.strip
product['reviews_count'] = review_text =~ /reviews/ ? review_text.split(' ').first.to_i : 0

#extract publisher
product['publisher'] = nokogiri.at_css('a.prod-brandName').text.strip

#extract walmart item number
product['walmart_number'] = nokogiri.at_css('div.wm-item-number').text.split('#').last.strip

#extract product image
product['img_url'] = nokogiri.at_css('div.prod-hero-image > img.larger-hero-image-carousel-image')['src'].split('?').first

#extract product categories
product['categories'] = nokogiri.css('.breadcrumb-list li').collect{|li| li.text.strip.gsub('/','') }

# specify the collection where this record will be stored
product['_collection'] = 'products'

# save the product to the job’s outputs
outputs << product