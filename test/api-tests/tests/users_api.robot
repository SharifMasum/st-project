*** Settings ***
Resource    ../resources/common.resource
Resource    ../resources/users.resource
Suite Setup    Create API Session

*** Test Cases ***
Register Happy Path
    ${username}=    New Random Username
    ${resp}=        Register    ${username}    Secret123!
    Should Be Equal As Integers    ${resp.status_code}    200
    ${json}=        Set Variable    ${resp.json()}
    Dictionary Should Contain Key    ${json}    accessToken
    Dictionary Should Contain Key    ${json}    refreshToken

Register Negative Missing Password Returns 422
    ${headers}=    Json Headers
    ${payload}=    Create Dictionary    username=someone
    ${resp}=       POST On Session    api    ${API_PREFIX}/users/    json=${payload}    headers=${headers}    expected_status=anything
    Should Be Equal As Integers    ${resp.status_code}    422

Login Happy Path
    ${username}=    New Random Username
    Register    ${username}    Secret123!
    ${resp}=    Login    ${username}    Secret123!
    Should Be Equal As Integers    ${resp.status_code}    200
    ${json}=    Set Variable    ${resp.json()}
    Dictionary Should Contain Key    ${json}    accessToken

Login Negative Missing Body Returns 422
    ${headers}=    Json Headers
    ${resp}=       POST On Session    api    ${API_PREFIX}/users/login    headers=${headers}    expected_status=anything
    Should Be Equal As Integers    ${resp.status_code}    422

Refresh Token Happy Path
    ${username}    ${access}    ${refresh}=    Ensure Logged In User
    ${resp}=        Refresh Token    ${access}    ${refresh}
    Should Be Equal As Integers    ${resp.status_code}    200

Refresh Token Negative Missing RefreshToken Returns 422
    ${username}    ${access}    ${refresh}=    Ensure Logged In User
    ${headers}=     Json Headers
    ${payload}=     Create Dictionary    accessToken=${access}
    ${resp}=        POST On Session    api    ${API_PREFIX}/users/refresh-token    json=${payload}    headers=${headers}    expected_status=anything
    Should Be Equal As Integers    ${resp.status_code}    422
