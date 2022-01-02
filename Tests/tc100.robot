*** Settings ***
Documentation    Heureka website regression suite
Library    SeleniumLibrary
Resource    ../Resources/Keywords/keywords.robot
Resource    ../Resources/Variables/variables.robot
Test Setup    Open Browser On AUT Homepage
Test Teardown    Close Browser


*** Test Cases ***
100 Adding and removing items from cart
    Click On    ${darceky}
    Click On    ${pre_par}
    Click On    ${prilezitost_vianoce}
    Choose Price Range    ${40_to_100}
    Buy Item And Add To Cart    ${stolove_hry}
    Click On Header Cart Button
    Cart Icon Number And Item Count Should Be Equal
    Price Of All Items In Cart Should Be In Range 40 To 100
#    Remove Top Single Item From Cart
#    Check If Cart Counter Decremented
#    Check If Top Single Item Was Deleted
#    Remove All Items In Cart Items
#    Check If Cart Is Empty

