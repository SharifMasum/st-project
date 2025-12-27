*** Settings ***
Resource    ../resources/app.robot
Suite Setup         Open App
Suite Teardown      Close App

*** Test Cases ***
Share A Todo List With Another User
    ${owner}=    Unique    owner
    ${rec}=      Unique    rec
    ${pw}=       Set Variable    TestPass123!

    Register User    ${owner}    ${pw}
    Register User    ${rec}      ${pw}

    Login    ${owner}    ${pw}
    ${list}=    Unique    SharedList
    Create List    ${list}    For sharing
    Open List      ${list}
    Add Item       OneItem
    Share List With User    ${rec}    viewer
    Logout

View A Todo List Shared With Me Including Todo Items
    ${owner}=    Unique    owner
    ${rec}=      Unique    rec
    ${pw}=       Set Variable    TestPass123!

    Register User    ${owner}    ${pw}
    Register User    ${rec}      ${pw}

    Login    ${owner}    ${pw}
    ${list}=    Unique    SharedList
    Create List    ${list}    For sharing
    Open List      ${list}
    ${item}=      Unique    Item
    Add Item       ${item}
    Share List With User    ${rec}    viewer
    Logout

    Login    ${rec}    ${pw}
    Open Shared Lists
    Wait For Elements State    css=text=${list}    visible
    Open List    ${list}
    Wait For Elements State    css=text=${item}    visible
