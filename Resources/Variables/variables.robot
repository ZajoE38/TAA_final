*** Variables ***
${AUT_URL}              https://www.heureka.sk/
${BROWSER_TYPE}         gc    #google chrome
@{ICON_COUNT}           init
${banner_darceky}       xpath://section[@id="today-tips-ads"]//a[@href="https://darceky.heureka.sk/"]
${pre_par}              xpath://section[contains(@class, "filter-target o-wrapper--fill")]//a[@href="/par/"]
${sub_vianoce}          xpath://section[contains(@class, "categories-section")]//a[@href="/par/vianoce/"]
${cena_40_to_100}       xpath://label[@for="40-100"]
${category_item}        xpath:(//div[@id="page-main"]//li[contains(@class, "c-product-list__item")])[1]
#  TODO - refactor repeating xpath substring
${item4}                xpath:(//ul[contains(@class, "c-product-list__items")]/li)[4]
${item5}                xpath:(//ul[contains(@class, "c-product-list__items")]/li)[5]
${item6}                xpath:(//ul[contains(@class, "c-product-list__items")]/li)[6]
${kupit_btn}            xpath://div[contains(@class, "js-cart c-top-position__buy")]
${do_kosika}            xpath://a[@href="https://www.heureka.sk/kosik/"]
${kosik}                xpath://a[@href="https://www.heureka.sk/kosik/"]//span[contains(@class, "c-user-controls__icon-container")]
${delete_item}          xpath:(//div[contains(@class, "c-responsive-cart__section-wrapper")])[1]//a[contains(@class, "js-modal__toggle e-action")]
${confirm_deletion}     xpath:(//a[contains(@href, "itemRemove")])[1]