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

Cart
    [Arguments]    ${element}
    Execute Javascript    window.location.reload(true);
    Click On    ${element}

Buy 3 Items And Add To Cart
    ${items} =    Create List    ${item4}    ${item5}    ${item6}
    FOR    ${item}    IN    @{items}
        Click On    ${stolove_hry}
        Switch Window    locator=NEW
        Click On    ${item}
        Wait Until Keyword Succeeds    1 min    5 sec    Click On    ${kupit}
        Wait Until Page Contains    Tovar sme pridali do košíka
        Sleep    5
        Close Window
        Switch Window    locator=MAIN
    END

Assert Cart Count
    Set Global Variable    @{ICON_COUNT}    get element attribute    ${kosik}    data-count
    Set Local Variable    ${items_in_cart}    xpath:(//div[contains(@class, "c-responsive-cart__section-wrapper")])
    Set Local Variable    ${item_count}    get length    ${items_in_cart}
    Should Be Equal As Integers    @{ICON_COUNT}    ${item_count}

Assert Price Range
    #  TODO - refactor repeating xpath substring
    Set Local Variable    ${items_in_cart}    xpath:(//div[contains(@class, "c-responsive-cart__section-wrapper")])//div[contains(@class, "c-product-card__price u-bold")]
    FOR    ${item}    IN    @{items_in_cart}
        ${is_in_range} =    Evaluate    39 < ${item} < 101
        Should Be True    ${is_in_range}
    END

Remove 1 Item From Cart
    click element    ${delete_item}
    wait until element is visible    ${confirm_deletion}
    click element    ${confirm_deletion}
    sleep    2

Assert Cart Icon Decrement
    ${count_before} =    @{ICON_COUNT}
    Set Global Variable    @{ICON_COUNT}    get element attribute    ${kosik}    data-count
    ${count_after} =    @{ICON_COUNT}
    ${is_decreased} =    Evaluate    ${count_before} - ${count_after} == 2
    Should Be True   ${is_decreased}

Assert Item Deletion
    Set Local Variable    ${items_in_cart}    xpath:(//div[contains(@class, "c-responsive-cart__section-wrapper")])
    Set Local Variable    ${item_count}    get length    ${items_in_cart}
    Should Be Equal As Integers    @{ICON_COUNT}    ${item_count}

Assert Removal Of 1 Item
    Assert Cart Icon Decrement
    Assert Item Deletion

Remove Remaining Items
    Set Local Variable    ${items}    xpath:(//div[contains(@class, "c-responsive-cart__section-wrapper")])
    FOR    ${item}    IN    ${items}
        click element    ${item}//a[contains(@class, "js-modal__toggle e-action")]
        wait until element is visible    ${confirm_deletion}
        click element    ${confirm_deletion}
        sleep    2
    END

Assert Empty Cart
    Set Global Variable    @{ICON_COUNT}    get element attribute    ${kosik}    data-count
    Should Be Equal As Integers    @{ICON_COUNT}    0
    Page Should Contain    Váš košík zíva prázdnotou