*** Settings ***
Resource    common.resource
Library     Collections

*** Keywords ***
Register
    [Arguments]    ${username}    ${password}
    ${headers}=    Json Headers
    ${payload}=    Create Dictionary    username=${username}    password=${password}
    ${resp}=       POST On Session    api    ${API_PREFIX}/users/    json=${payload}    headers=${headers}
    RETURN       ${resp}

Login
    [Arguments]    ${username}    ${password}
    ${headers}=    Json Headers
    ${payload}=    Create Dictionary    username=${username}    password=${password}
    ${resp}=       POST On Session    api    ${API_PREFIX}/users/login    json=${payload}    headers=${headers}
    RETURN       ${resp}

Refresh Token
    [Arguments]    ${access_token}    ${refresh_token}
    ${headers}=    Json Headers
    ${payload}=    Create Dictionary    accessToken=${access_token}    refreshToken=${refresh_token}
    ${resp}=       POST On Session    api    ${API_PREFIX}/users/refresh-token    json=${payload}    headers=${headers}
    RETURN       ${resp}

Extract Tokens
    [Arguments]    ${resp}
    ${json}=       Set Variable    ${resp.json()}
    ${access}=     Get From Dictionary    ${json}    accessToken
    ${refresh}=    Get From Dictionary    ${json}    refreshToken
    RETURN       ${access}    ${refresh}

Ensure Logged In User
    [Arguments]    ${password}=Secret123!
    ${username}=   New Random Username
    ${reg}=        Register    ${username}    ${password}
    Should Be Equal As Integers    ${reg.status_code}    200
    ${login}=      Login    ${username}    ${password}
    Should Be Equal As Integers    ${login.status_code}    200
    ${access}    ${refresh}=    Extract Tokens    ${login}
    RETURN      ${username}    ${access}    ${refresh}
