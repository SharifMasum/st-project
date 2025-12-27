*** Settings ***
Resource    ../resources/app.robot
Suite Setup       Open App
Suite Teardown    Close App
Test Setup        Ensure Logged Out

*** Test Cases ***
Create And Delete Todo Lists
    ${u}=    Unique    user
    ${pw}=   Set Variable    TestPass123!
    Register User    ${u}    ${pw}
    Login    ${u}    ${pw}

    ${list}=    Unique    List
    Create List    ${list}    My test list

Modify A Todo List Name And Description
    ${u}=    Unique    user
    ${pw}=   Set Variable    TestPass123!
    Register User    ${u}    ${pw}
    Login    ${u}    ${pw}

    ${list}=    Unique    List
    Create List    ${list}    Desc
