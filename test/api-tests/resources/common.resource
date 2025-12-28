*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${BASE_URL}    http://localhost:3000    # change to your API host/port
${API_PREFIX}  /api

*** Keywords ***
Create API Session
    Create Session    api    ${BASE_URL}

Set Json Headers
    ${headers}=    Create Dictionary    Content-Type=application/json
    [Return]    ${headers}

Set Auth Headers
    [Arguments]    ${token}
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${token}
    [Return]    ${headers}
