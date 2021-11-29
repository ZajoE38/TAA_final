*** Settings ***
Resource    ./Resources/Variables/variables.robot


*** Keywords ***
Open Browser On AUT Homepage
    Open Browser        ${AUT_URL}    ${BROWSER_TYPE}
    Set Window Size     1920    1080

Click On Darceky
    wait until element is visible    ${banner_darceky}
    click element    ${banner_darceky}

#  TODO - finish & implement
Random Element
    Set Local Variable    ${locator}    xpath:(//section[contains(@class, "filter-target o-wrapper--fill")]//a)
    ${random_number}    Evaluate    random.randint(1, 5)    random
#    Click Element    ${locator}[${random_number}]
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

Assert Cart Count
    Set Global Variable    ${ICON_COUNT}    get element attribute    ${kosik}    data-count
    Set Local Variable    ${items_in_cart}    xpath:(//div[contains(@class, "c-responsive-cart__section-wrapper")])
    Set Local Variable    ${item_count}    get length    ${items_in_cart}
    Should Be Equal As Integers    ${ICON_COUNT}    ${item_count}

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
    ${count_before} =    ${ICON_COUNT}
    Set Global Variable    ${ICON_COUNT}    get element attribute    ${kosik}    data-count
    ${count_after} =    ${ICON_COUNT}
    ${is_decreased} =    Evaluate    ${count_before} - ${count_after} == 2
    Should Be True   ${is_decreased}

Assert Item Deletion
    Set Local Variable    ${items_in_cart}    xpath:(//div[contains(@class, "c-responsive-cart__section-wrapper")])
    Set Local Variable    ${item_count}    get length    ${items_in_cart}
    Should Be Equal As Integers    ${ICON_COUNT}    ${item_count}

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
    Set Global Variable    ${ICON_COUNT}    get element attribute    ${kosik}    data-count
    Should Be Equal As Integers    ${ICON_COUNT}    0
    Page Should Contain    Váš košík zíva prázdnotou