*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    String

*** Variables ***
${BASE_URL}      http://localhost:4322
${API_PREFIX}    /api

*** Keywords ***
Create API Session
    Create Session    api    ${BASE_URL}

Json Headers
    ${h}=    Create Dictionary    Content-Type=application/json
    RETURN    ${h}

Auth Headers
    [Arguments]    ${access_token}
    # Most FastAPI JWT setups use Bearer tokens.
    ${h}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${access_token}
    RETURN    ${h}

New Random Username
    ${rand}=    Generate Random String    10    [LETTERS][NUMBERS]
    RETURN    user_${rand}
