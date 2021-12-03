*** Variables ***
${AUT_URL}              https://www.heureka.sk/
${BROWSER_TYPE}         gc    #google chrome
@{HEADER_CART_COUNT}

#  enum - price ranges
${0_to_20}              xpath://label[@for="0-20"]
${20_to_40}             xpath://label[@for="20-40"]
${40_to_100}            xpath://label[@for="40-100"]
${100_and_more}         xpath://label[@for="100-"]
#  END

${darceky}              xpath://a[@title="Tipy na darčeky"]
${pre_par}              xpath://a[@data-label="Pár"]
${prilezitost_vianoce}  xpath://label//span[text()="Vianoce"]
${stolove_hry}          xpath://li[@data-name="Stolové hry"]
${item4}                xpath:(//ul[contains(@class, "c-product-list__items")]/li)[4]
${item5}                xpath:(//ul[contains(@class, "c-product-list__items")]/li)[5]
${item6}                xpath:(//ul[contains(@class, "c-product-list__items")]/li)[6]
#${item}                 xpath:(//ul[contains(@class, "c-product-list__items")]/li)
#${item4}                ${item}[4]
#${item5}                ${item}[5]
#${item6}                ${item}[6]

#${kupit}                xpath://div[contains(@class, "js-cart c-top-position__buy")]
${kupit}                xpath://button[@data-test-id="js_cart_submit"]

#${header_cart}          xpath://a[@href="https://www.heureka.sk/kosik/"]
${header_cart}          xpath://li[contains(@class, "c-user-controls__item--cart")]

${in_cart_items}        xpath:(//div[contains(@class, "c-responsive-cart__section-wrapper")])
${delete_top_item}          ${in_cart_items}[1]//a[contains(@class, "js-modal__toggle e-action")]
${confirm_deletion}     xpath:(//a[contains(@href, "itemRemove")])[1]