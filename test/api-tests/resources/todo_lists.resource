*** Settings ***
Resource    common.resource
Library     Collections

*** Keywords ***
Create Todo List
    [Arguments]    ${access_token}    ${name}    ${description}=${None}
    ${headers}=    Auth Headers    ${access_token}
    ${payload}=    Create Dictionary    name=${name}    description=${description}
    ${resp}=       POST On Session    api    ${API_PREFIX}/todo-lists/    json=${payload}    headers=${headers}
    RETURN       ${resp}

Find Todo Lists
    [Arguments]    ${access_token}
    ${headers}=    Auth Headers    ${access_token}
    ${resp}=       GET On Session    api    ${API_PREFIX}/todo-lists/    headers=${headers}
    RETURN       ${resp}

Update Todo List
    [Arguments]    ${access_token}    ${todo_list_id}    ${name}    ${description}=${None}
    ${headers}=    Auth Headers    ${access_token}
    ${payload}=    Create Dictionary    name=${name}    description=${description}
    ${resp}=       PUT On Session    api    ${API_PREFIX}/todo-lists/${todo_list_id}    json=${payload}    headers=${headers}
    RETURN       ${resp}

Extract Todo List Id
    [Arguments]    ${resp}
    ${json}=       Set Variable    ${resp.json()}
    ${id}=         Get From Dictionary    ${json}    id
    RETURN       ${id}
