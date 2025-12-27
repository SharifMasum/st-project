*** Settings ***
Resource    ../resources/app.robot
Suite Setup         Open App
Suite Teardown      Close App

*** Test Cases ***
Create And Delete Todo Items In A Todo List
    ${u}=    Unique    user
    ${pw}=   Set Variable    TestPass123!
    Register User    ${u}    ${pw}
    Login    ${u}    ${pw}

    ${list}=    Unique    List
    Create List    ${list}    Desc
    Open List      ${list}

    ${item}=    Unique    Item
    Add Item      ${item}
    Delete Item   ${item}

Edit A Todo Item Description
    ${u}=    Unique    user
    ${pw}=   Set Variable    TestPass123!
    Register User    ${u}    ${pw}
    Login    ${u}    ${pw}

    ${list}=    Unique    List
    Create List    ${list}    Desc
    Open List      ${list}

    ${item}=    Unique    Item
    Add Item      ${item}
    ${edited}=  Unique    ItemEdited
    Edit Item     ${item}    ${edited}
