click_captha_code = " 
await sleep(3000);
if ( (await page.$('div#js-global-footer-wrapper')) == null ){
  await sleep(5412);
  if ( (await page.$('div#px-captcha')) !== null ) {
    // hover to the captha validation and sleep a bit
    await page.hover('iframe[style*=\"display: block\"]'); 
    await sleep(1428); 
    // click hold and wait loading new page
    await Promise.all([
      page.waitForNavigation(),
      page.click('iframe[style*=\"display: block\"]', {delay: 9547}),
    ]); 
  };
};
// FINAL CHECK
page.waitForSelector('div#js-global-footer-wrapper', {timeout: 2000})
"

pages << {
  url: 'https://www.walmart.com/browse/movies-tv-shows/movies/4096_530598/?cat_id=4096_530598&facet=new_releases%3ALast+90+Days',
  page_type: "listings",
  fetch_type: 'browser',
  force_fetch: true,
  method: "GET",
  headers: {"User-Agent" => "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36"},
  driver: {
    code: click_captha_code
  }
}