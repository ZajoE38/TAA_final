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


Buy Item And Add To Cart
    [Arguments]    ${category}
    FOR    ${element}    IN    ${item1}    ${item2}
        Click On    ${category}
        Switch Window    locator=NEW
        Click On    ${element}
        Click On    ${kupit}
        ${isPresent} =    Page Should Contain Button    ${kupit_popup}
        IF    ${isPresent} == "PASS"
              Click On    ${kupit_popup}
        END
        Page Should Contain    Tovar sme pridali do košíka
        Sleep    1s
        Close Window
        Switch Window    locator=MAIN
    END


Click On Header Cart Button
    Execute Javascript    window.location.reload(true);
    Click On    ${header_cart}


Cart Icon Number And Item Count Should Be Equal
    ${string_cart_count}    get element attribute    ${header_cart}//span[@data-count]    data-count
    @{webelements_cart}    Get Webelements    //span[@class='c-product-card__title']
    ${item_count}    Get Length    ${webelements_cart}
    Should Be Equal As Integers    ${string_cart_count}    ${item_count}


Price Of All Items In Cart Should Be In Range 40 To 100
    @{items}    Get Webelements    ${in_cart_items}//div[contains(@class, "c-product-card__price u-bold")]
    FOR    ${item}    IN    @{items}
        ${item_price}    Get Text    ${item}
#        ${item_price}    Evaluate    ${item_price}.split(" ")[0].replace(",", ".")
#        ${item_price}    Evaluate    ${item_price}.split(" ")[1].replace("€", "")
        ${item_price}    Evaluate    ${item_price}.replace(" €", "")
        ${item_price}    Evaluate    ${item_price}.replace(",", ".")
        ${item_price}    Evaluate    float(${item_price})
        Should Be True    39 < ${item_price} < 101
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