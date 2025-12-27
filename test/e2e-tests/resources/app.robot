*** Settings ***
Library    Browser
Resource   locators.robot

*** Variables ***
${BASE_URL}         %{FRONTEND_URL=http://localhost/}
${BROWSER}          chromium
${HEADLESS}         ${TRUE}
${DEFAULT_TIMEOUT}  20s

*** Keywords ***
Open App
    New Browser    ${BROWSER}    headless=${HEADLESS}
    New Context    viewport={'width': 1280, 'height': 720}
    New Page       ${BASE_URL}
    Set Browser Timeout    ${DEFAULT_TIMEOUT}
    Wait For Elements State    ${LOGIN_USERNAME}    visible

Close App
    Close Browser

Unique
    [Arguments]    ${prefix}
    ${ts}=    Get Time    epoch
    RETURN    ${prefix}-${ts}

Go To Register
    Run Keyword And Ignore Error    Click    ${BTN_TO_REGISTRATION}
    Run Keyword And Ignore Error    Click    ${LINK_REGISTER}
    Wait For Elements State    ${REG_USERNAME}    visible

Go To Login
    Go To    ${BASE_URL}
    Wait For Elements State    ${BTN_LOGIN}    visible    timeout=20s
    Wait For Elements State    ${LOGIN_USERNAME}    visible    timeout=20s

Register User
    [Arguments]    ${username}    ${password}
    Go To Register
    Fill Text    ${REG_USERNAME}    ${username}
    Fill Text    ${REG_PASSWORD}    ${password}
    Run Keyword And Ignore Error    Fill Text    ${REG_PASSWORD2}    ${password}
    # submit reliably
    Press Keys    ${REG_PASSWORD}    Enter
    Go To Login

Login
    [Arguments]    ${username}    ${password}
    Go To Login
    Fill Text    ${LOGIN_USERNAME}    ${username}
    Fill Text    ${LOGIN_PASSWORD}    ${password}
    Run Keyword And Ignore Error    Click    ${BTN_LOGIN}
    Press Keys    ${LOGIN_PASSWORD}    Enter
    Wait Until Keyword Succeeds    15x    1s    Should Be Logged In

Should Be Logged In
    Wait For Elements State    ${LOGIN_USERNAME}    detached

Open New List Form
    # if already open, name field is visible
    ${status}    ${msg}=    Run Keyword And Ignore Error    Wait For Elements State    ${FIELD_LIST_NAME}    visible    timeout=500ms
    IF    '${status}' == 'PASS'
        RETURN
    END
    Click    ${BTN_NEW_TODO_LIST}
    Wait For Elements State    ${FIELD_LIST_NAME}    visible    timeout=2s

Click Create List Button
    Wait For Elements State    ${BTN_CREATE_LIST}    visible
    Click    ${BTN_CREATE_LIST}

Logout
    # Try normal UI logout
    Run Keyword And Ignore Error    Click    ${BTN_LOGOUT}
    Run Keyword And Ignore Error    Click    ${LINK_LOGOUT}
    Run Keyword And Ignore Error    Click    css=button:has-text("Sign out")
    Run Keyword And Ignore Error    Click    css=a:has-text("Sign out")

    # Navigate to root and check if login is visible
    Go To    ${BASE_URL}
    ${status}    ${msg}=    Run Keyword And Ignore Error    Wait For Elements State    ${LOGIN_USERNAME}    visible    timeout=3s
    IF    '${status}' == 'PASS'
        RETURN
    END

    # If still logged in, force session reset (fallback)
    Clear Cookies
    Evaluate JavaScript    localStorage.clear()
    Evaluate JavaScript    sessionStorage.clear()
    Reload

    # Now login must be visible
    Wait For Elements State    ${LOGIN_USERNAME}    visible    timeout=20s

Logout Via UI
    Click    ${LINK_LOGOUT}
    # After clicking logout, login form should appear (or you should be redirected)
    Go To    ${BASE_URL}
    Wait For Elements State    ${LOGIN_USERNAME}    visible    timeout=20s

Ensure Logged Out
    Go To    ${BASE_URL}
    ${status}    ${msg}=    Run Keyword And Ignore Error    Wait For Elements State    ${LOGIN_USERNAME}    visible    timeout=2s
    IF    '${status}' == 'PASS'
        RETURN
    END
    # Not on login page -> try logout then go back
    Run Keyword And Ignore Error    Click    ${BTN_LOGOUT}
    Run Keyword And Ignore Error    Click    ${LINK_LOGOUT}
    Go To    ${BASE_URL}
    Wait For Elements State    ${LOGIN_USERNAME}    visible    timeout=20s

# Helper keywords for locator fallbacks

Click First Visible
    [Arguments]    @{locators}
    FOR    ${loc}    IN    @{locators}
        ${status}    ${msg}=    Run Keyword And Ignore Error    Wait For Elements State    ${loc}    visible    timeout=1s
        IF    '${status}' == 'PASS'
            Click    ${loc}
            RETURN
        END
    END
    Fail    None of the locators were visible: ${locators}

Fill First Visible
    [Arguments]    ${text}    @{locators}
    FOR    ${loc}    IN    @{locators}
        ${status}    ${msg}=    Run Keyword And Ignore Error    Wait For Elements State    ${loc}    visible    timeout=1s
        IF    '${status}' == 'PASS'
            Fill Text    ${loc}    ${text}
            RETURN
        END
    END
    Fail    None of the locators were visible for filling: ${locators}

# Todo list keywords

Create List
    [Arguments]    ${name}    ${desc}

    # Ensure form is open
    Wait Until Keyword Succeeds    5x    500ms    Open New List Form

    Fill Text    ${FIELD_LIST_NAME}    ${name}
    Fill Text    ${FIELD_LIST_DESC}    ${desc}

    Wait Until Keyword Succeeds    10x    500ms    Click Create List Button

    Wait For Elements State    css=a:has-text("${name}")    visible



