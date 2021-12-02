*** Settings ***
Documentation    Suite description
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
    Buy 3 Items And Add To Cart
    Go To Cart
#    Assert Cart Count
#    Assert Price Range
#    Remove 1 Item From Cart
#    Assert Removal Of 1 Item
#    Remove Remaining Items
#    Assert Empty Cart

