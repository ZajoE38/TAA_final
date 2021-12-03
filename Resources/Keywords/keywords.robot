*** Settings ***
Resource    ../Variables/variables.robot


*** Keywords ***
Open Browser On AUT Homepage
    Open Browser        ${AUT_URL}    ${BROWSER_TYPE}
    Set Window Size     1920    1080

#  TODO - finish & implement
Random Element
    Set Local Variable    ${locator}    xpath:(//section[contains(@class, "filter-target o-wrapper--fill")]//a)
    ${random_number}    Evaluate    random.randint(1, 5)    random
#    Click Element    ${locator}[${random_number}]
    Log    ${locator}

Click On
    [Arguments]    ${element}
    wait until element is visible    ${element}
    click element    ${element}

Choose Price Range
    [Arguments]    ${range_element}
    Click On    ${range_element}

Buy 3 Items And Add To Cart
    [Documentation]     Picks 3 hardcoded items that contains button {kupit},
    ...                 opens it it new window, click buy, close window and repeat 3 times
    ${items} =    Create List    ${item4}    ${item5}    ${item6}
    FOR    ${item}    IN    @{items}
        Click On    ${stolove_hry}
        Switch Window    locator=NEW
        Click On    ${item}
        Sleep    5s
        Wait Until Keyword Succeeds    30sec    3sec    Wait Until Element Is Visible    ${kupit}
        Wait Until Keyword Succeeds    30sec    3sec    Click On    ${kupit}
        Close Window
        Switch Window    locator=MAIN
    END

Click On Header Cart Button
    Execute Javascript    window.location.reload(true);
    Click On    ${header_cart}

Check Cart Icon Number And Item Count Are Equal
    Set Global Variable    @{HEADER_CART_COUNT}    get element attribute    ${header_cart}    data-count
    Set Local Variable    @{item_count}    get length    ${in_cart_items}
    Should Be Equal As Integers    @{HEADER_CART_COUNT}    @{item_count}

Check Price Of All Items In Cart Is In Range 40 To 100
    Set Local Variable    ${items_price}    ${in_cart_items}//div[contains(@class, "c-product-card__price u-bold")]
    FOR    ${item_price}    IN    @{items_price}
        Should Be True    Evaluate    39 < ${item_price} < 101
    END

Remove Top Single Item From Cart
    click element    ${delete_top_item}
    wait until element is visible    ${confirm_deletion}
    click element    ${confirm_deletion}
#    sleep    2

Check If Cart Counter Decremented
    Set Local Variable    ${price_before} =    @{HEADER_CART_COUNT}
    #  Update variable
    Set Global Variable    @{HEADER_CART_COUNT}    get element attribute    ${header_cart}    data-count
    Set Local Variable    ${price_after}
    Should Be True    Evaluate    ${price_before} - ${price_after} == 1

Check If Top Single Item Was Deleted
    Set Local Variable    ${items_in_cart}    xpath:(//div[contains(@class, "c-responsive-cart__section-wrapper")])
    Set Local Variable    @{item_count}    get length    ${items_in_cart}
    Should Be Equal As Integers    @{ICON_COUNT}    @{item_count}


Remove All Items In Cart Items
    Set Local Variable    ${items}    xpath:(//div[contains(@class, "c-responsive-cart__section-wrapper")])
    FOR    ${item}    IN    ${items}
        click element    ${item}//a[contains(@class, "js-modal__toggle e-action")]
        wait until element is visible    ${confirm_deletion}
        click element    ${confirm_deletion}
        sleep    2
    END

Check If Cart Is Empty
    Set Global Variable    @{ICON_COUNT}    get element attribute    ${header_cart}    data-count
    Should Be Equal As Integers    @{ICON_COUNT}    0
    Page Should Contain    Váš košík zíva prázdnotou