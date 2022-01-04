*** Settings ***
Resource    ../Variables/variables.robot


*** Keywords ***
Open Browser On AUT Homepage
    Open Browser        ${AUT_URL}    ${BROWSER_TYPE}
    Set Window Size     1920    1080


#  TODO - finish & implement
Random Element
    Set Variable    ${locator}    xpath:(//li[@class='l0 leftMenuItem hm'])
    ${random_number}    Evaluate    random.randint(1, 19)    random
    Click Element    ${locator}[${random_number}]   #xpath:(//li[@class='l0 leftMenuItem hm'])[3]


Click On
    [Arguments]    ${element}
    wait until element is visible    ${element}
    click element    ${element}


Choose Price Range
    [Arguments]    ${range_enum_element}
    Click On    ${range_enum_element}


Choose Random Items And Add To Cart
    [Arguments]    ${category}    ${count}
    ${elements}    Create List
    FOR    ${i}    IN RANGE    9999999
        Click On    ${category}
        Switch Window    locator=NEW
        ${elements} =    Get WebElements    (//ul[contains(@class, "c-product-list__items")]/li)
        ${counter} =    ${0}
        FOR    ${element}    IN    @{elements}
            ${present} =    Run Keyword And Return Status    Page Should Contain Element   ${kupit}
            IF    ${present} == "PASS"
                Click On    ${element}
                Click On    ${kupit}
                ${counter} =      ${counter} + ${1}
            END
            Exit For Loop If    ${counter} == ${count}
        END
        Close Window
        Switch Window    locator=MAIN
        Exit For Loop If    ${counter} == ${count}
    END

Click On Element If Present
    [Arguments]    ${element}
    ${isPresent} =    Page Should Contain Button    ${element}
    IF    ${isPresent} == "PASS"
        Click On    ${element}
    END

#  TODO - add second param - count
Buy Item And Add To Cart
    [Arguments]    ${category}
    Click On    ${category}
    Switch Window    locator=NEW
    FOR    ${element}    IN    ${item1}    ${item2}    ${item3}
        Click On    ${element}
        Click On    ${kupit}
        Run Keyword And Ignore Error    Click On Element If Present    ${kupit_popup}
        Page Should Contain    Tovar sme pridali do košíka
        Go Back
    END
    Close Window
    Switch Window    locator=MAIN


Click On Header Cart Button
    Reload Page
    Click On    ${header_cart}


Cart Icon Number And Item Count Should Be Equal
    ${string_cart_count}    get element attribute    ${header_cart}//span[@data-count]    data-count
    @{webelements_cart}    Get Webelements    //span[@class='c-product-card__title']
    ${item_count}    Get Length    ${webelements_cart}
    Should Be Equal As Integers    ${string_cart_count}    ${item_count}


Price Of All Items In Cart Should Be In Range
    [Arguments]    ${lower_bound}    ${upper_bound}
    @{items}    Get Webelements    ${in_cart_items}//div[contains(@class, "c-product-card__price u-bold")]
    FOR    ${item}    IN    @{items}
        ${item_price}    Get Text    ${item}
        ${item_price}    Evaluate    ${item_price}[:2]
        Should Be True    ${lower_bound} <= ${item_price} <= ${upper_bound}
    END


Store Current Cart Count Number Value
    ${number} =    Get Element Attribute    ${cart_icon}    data-count
    Log    ${number}
    Set Suite Variable    ${HEADER_CART_COUNT}    ${number}


Store Top Item Identifier
    ${id} =    Get Element Attribute    ${cart_item_1}    data-item-id
    Log    ${id}
    Set Suite Variable    ${TOP_ITEM_ID}    ${id}


Remove Top Single Item From Cart
    Store Current Cart Count Number Value
    Store Top Item Identifier
    Click Link    ${delete_top_item}
    Click Link    ${confirm_deletion}


Cart Counter Should Be Decremented
    ${price_before}    Set Variable    ${HEADER_CART_COUNT}
    Store Current Cart Count Number Value
    ${price_after}    Set Variable    ${HEADER_CART_COUNT}
    Should Be True    ${price_before} - ${price_after} == 1


Top Single Item Should Be Deleted
    ${id_before}    Set Variable    ${TOP_ITEM_ID}
    Store Top Item Identifier
    ${id_after}    Set Variable    ${TOP_ITEM_ID}
    Should Not Be Equal    ${id_before}    ${id_after}


Remove All Items From Cart
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