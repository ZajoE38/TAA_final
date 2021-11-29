*** Settings ***
Documentation    Suite description
Library    SeleniumLibrary
Resource    ./Resources/Keywords/keywords.robot
Resource    ./Resources/Variables/variables.robot
Test Setup    Open Browser On AUT Homepage
Test Teardown    Close Browser


*** Test Cases ***
100 Adding and removing items from cart
    Click On Darceky
    Click On Pre Par
    Click On Vianoce
    Choose Price Range
    Buy 3 Items
    Go To Cart
    Assert Cart Count
    Assert Price Range
    Remove 1 Item From Cart
    Assert Removal Of 1 Item
    Remove Remaining Items
    Assert Empty Cart

