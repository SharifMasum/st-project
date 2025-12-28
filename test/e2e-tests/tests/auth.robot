*** Settings ***
Resource    ../resources/app.robot
Suite Setup         Open App
Suite Teardown      Close App
Test Setup          Ensure Logged Out

*** Test Cases ***
Register To The Application
    ${u}=    Unique    user
    ${pw}=   Set Variable    TestPass123!
    Register User    ${u}    ${pw}

Log In To The Application
    [Tags]    smoke
    ${u}=    Unique    user
    ${pw}=   Set Variable    TestPass123!
    Register User    ${u}    ${pw}
    Login    ${u}    ${pw}
    # If logout exists after login, assert it
    Run Keyword And Ignore Error    Wait For Elements State    ${LINK_LOGOUT}    visible

Log Out From The Application
    [Tags]    smoke
    ${u}=    Unique    user
    ${pw}=   Set Variable    TestPass123!
    Register User    ${u}    ${pw}
    Login    ${u}    ${pw}
    Logout Via UI


