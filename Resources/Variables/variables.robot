*** Variables ***
${AUT_URL}              https://www.heureka.sk/
${BROWSER_TYPE}         gc    #google chrome
${ICON_COUNT}           init
${banner_darceky}       xpath://section[@id="today-tips-ads"]//a[@href="https://darceky.heureka.sk/"]
${pre_par}              xpath://section[contains(@class, "filter-target o-wrapper--fill")]//a[@href="/par/"]
${sub_vianoce}          xpath://section[contains(@class, "categories-section")]//a[@href="/par/vianoce/"]
${cena_40_to_100}       xpath://label[@for="40-100"]
${category_item}        xpath:(//div[@id="page-main"]//li[contains(@class, "c-product-list__item")])[1]
${item_head}            xpath:(//ul[contains(@class, "c-product-list__items")]/li)
${item4}                ${item_head}[4]
${item5}                ${item_head}[5]
${item6}                ${item_head}[6]
${kupit_btn}            xpath://div[contains(@class, "js-cart c-top-position__buy")]
${cart}                 xpath://a[@href="https://www.heureka.sk/kosik/"]
${cart_checkout}        ${cart}//span[contains(@class, "c-user-controls__icon-container")]
${checkout_item}        xpath:(//div[contains(@class, "c-responsive-cart__section-wrapper")])
${item_delete_first}    ${checkout_item}[1]//a[contains(@class, "js-modal__toggle e-action")]
${confirm_deletion}     xpath:(//a[contains(@href, "itemRemove")])