*** Settings ***
Documentation    Suite description
Library    SeleniumLibrary
Library    String
Test Setup    Open Browser On AUT Homepage
Test Teardown    Close Browser


*** Variables ***
${AUT_URL}              https://www.heureka.sk/
${BROWSER_TYPE}         gc    #google chrome

${banner_darceky}       xpath=//section[@id="today-tips-ads"]//a[@href="https://darceky.heureka.sk/"]
${pre_koho_section}     xpath=//section[contains(@class, "filter-target o-wrapper--fill")]//a


*** Keywords ***
Open Browser On AUT Homepage
    Open Browser        ${AUT_URL}    ${BROWSER_TYPE}
    Set Window Size     1920    1080

Page Should Be Open
    Get Url   ==    ${AUT_URL}

Click On Darceky
    wait until element is visible    ${banner_darceky}
    click element    ${banner_darceky}

Get Stuff
    Set Variable    @{webelements}    ${pre_koho_section}
    ${random_range}    get length    @{webelements}
    ${random_num}    Evaluate    random.randint()




*** Test Cases ***
100 Adding and removing items from cart
    Page Should Be Open
    Click On Darceky
    Get Stuff



