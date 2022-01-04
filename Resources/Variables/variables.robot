*** Variables ***
${AUT_URL}              https://www.heureka.sk/
${BROWSER_TYPE}         gc    #google chrome

#  enum - price ranges
${0_to_20}              xpath://label[@for="0-20"]
${20_to_40}             xpath://label[@for="20-40"]
${40_to_100}            xpath://label[@for="40-100"]
${100_and_more}         xpath://label[@for="100-"]
#  END

${darceky}              xpath://a[@href="https://darceky.heureka.sk/"]
${pre_par}              xpath://a[@data-label="Pár"]
${prilezitost_vianoce}  xpath://label//span[text()="Vianoce"]
${stolove_hry}          xpath://li[@data-name="Stolové hry"]
${kartove_hry}          xpath://li[@data-name="Kartové hry"]
${produkty}             xpath:(//ul[contains(@class, "c-product-list__items")]/li)
${item1}                xpath:(//ul[contains(@class, "c-product-list__items")]/li)[1]
${item2}                xpath:(//ul[contains(@class, "c-product-list__items")]/li)[6]
${item3}                xpath:(//ul[contains(@class, "c-product-list__items")]/li)[9]

${kupit}                xpath://button[contains(@class, "c-top-offer__cart-button e-button")]
${kupit_popup}          xpath://button[contains(@class, "c-variant__button e-button e-button--highlight u-micro")]
${to_cart}              xpath://a[contains(@class, "c-cart-confirm__button--cart e-button e-button--highlight")]
${header_cart}          xpath://li[contains(@class, "c-user-controls__item--cart")]
${cart_icon}            ${header_cart}//span[contains(@class, "c-user-controls__icon-container")]

${in_cart_items}        xpath://div[contains(@class, "c-responsive-cart__section-wrapper")]
${cart_item_1}          xpath:(//div[contains(@class, "c-product-card js-cart-step1__product-card")])[1]

${delete_top_item}      xpath:(//div[contains(@class, "c-responsive-cart__section-wrapper")])[1]//a[contains(@class, "js-modal__toggle e-action")]
${confirm_deletion}     xpath:(//a[contains(@href, "itemRemove")])[1]