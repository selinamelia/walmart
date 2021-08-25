nokogiri = Nokogiri.HTML(content)

# initialize an empty hash
product = {}

#extract title
product['title'] = nokogiri.at_css('.prod-ProductTitle').text.strip

#extract current price
current_price = nokogiri.at_css('span#price').attr('content').to_f
if current_price
    product['price'] = nokogiri.at_css('span.visuallyhidden').text
end

#extract original price
original_price = nokogiri.at_css('span.xxs-margin-left:nth-child(1) > span:nth-child(1)')
product['original_price'] = original_price ? original_price.text.strip.split.last.gsub('$', '').to_f : nil

#extract rating
rating = nokogiri.at_css('button.average-rating > span:nth-child(1) > span:nth-child(1)').text.strip.to_f
product['rating'] = rating == 0 ? nil : rating

#extract number of reviews
review_text = nokogiri.at_css('span.stars-reviews-count-node').text.strip
product['reviews_count'] = review_text =~ /reviews/ ? review_text.split(' ').first.to_i : 0

#extract publisher
product['publisher'] = nokogiri.at_css('a.prod-brandName').text.strip

#extract walmart item number
product['walmart_number'] = nokogiri.at_css('div.wm-item-number').text.split('#').last.strip

#extract product image
img_url = nokogiri.at_css('.prod-hero-image-image')['src'].split('?').first
product['img_url'] = "https:#{img_url}"

#extract product categories
product['categories'] = nokogiri.css('.breadcrumb-list li').collect{|li| li.text.strip.gsub('/','') }

# specify the collection where this record will be stored
product['_collection'] = 'products'

# save the product to the job’s outputs
outputs << product