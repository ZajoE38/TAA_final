*** Settings ***
Documentation    Suite description
Library    SeleniumLibrary
Test Setup    Open Browser On AUT Homepage
Test Teardown    Close Browser


*** Variables ***
${AUT_URL}              https://www.heureka.sk/
${BROWSER_TYPE}         gc    #google chrome

${banner_darceky}       //section[@id="today-tips-ads"]//a[@href="https://darceky.heureka.sk/"]
${pre_par}              //section[contains(@class, "filter-target o-wrapper--fill")]//a[@href="/par/"]
${sub_vianoce}          //section[contains(@class, "categories-section")]//a[@href="/par/vianoce/"]
${cena_40_to_100}       //label[@for="40-100"]
${category_item}        xpath:(//div[@id="page-main"]//li[contains(@class, "c-product-list__item")])[1]
#  refactor
${item4}                xpath:(//ul[contains(@class, "c-product-list__items")]/li)[4]
${item5}                xpath:(//ul[contains(@class, "c-product-list__items")]/li)[5]
${item6}                xpath:(//ul[contains(@class, "c-product-list__items")]/li)[6]
${kupit_btn}            //div[contains(@class, "js-cart c-top-position__buy")]
${do_kosika}            //a[@href="https://www.heureka.sk/kosik/"]


*** Keywords ***
Open Browser On AUT Homepage
    Open Browser        ${AUT_URL}    ${BROWSER_TYPE}
    Set Window Size     1920    1080

Click On Darceky
    wait until element is visible    ${banner_darceky}
    click element    ${banner_darceky}

Random Element
    set local variable    ${locator}    xpath:(//section[contains(@class, "filter-target o-wrapper--fill")]//a)
    ${random_number}    Evaluate    random.randint(1, 5)    random
    Click Element    ${locator}[${random_number}]
    Log    ${locator}

Click On Pre Par
    wait until element is visible    ${pre_par}
    click element    ${pre_par}

Click On Vianoce
    wait until element is visible    ${sub_vianoce}
    click element    ${sub_vianoce}

Choose Price Range
    wait until element is visible    ${cena_40_to_100}
    click element    ${cena_40_to_100}
    sleep    3

Click On Category
    wait until element is visible    ${category_item}
    click element    ${category_item}
    sleep    2

Click On Kupit na Heureke
    sleep    3
    wait until element is visible    ${kupit_btn}
    click element    ${kupit_btn}
    wait until page contains    Tovar sme pridali do košíka

Buy 3 Items
    ${items} =    Create List    ${item4}    ${item5}    ${item6}
    FOR    ${item}    IN    @{items}
        Click On Category
        Switch Window    locator=NEW
        Click Element    ${item}
        Wait Until Keyword Succeeds    1 min    5 sec    Click On Kupit na Heureke
        wait until page contains    Tovar sme pridali do košíka
        sleep    5
        Close Window
        Switch Window    locator=MAIN
    END

Go To Cart
    Execute Javascript    window.location.reload(true);
    wait until element is visible    ${do_kosika}
    click element    ${do_kosika}


*** Test Cases ***
100 Adding and removing items from cart
    Click On Darceky
    Click On Pre Par
    Click On Vianoce
    Choose Price Range
    Buy 3 Items
    Go To Cart

