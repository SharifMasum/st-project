*** Settings ***
Resource    common.resource
Library     Collections

*** Keywords ***
Create Todo Item
    [Arguments]    ${access_token}    ${todo_list_id}    ${description}    ${due_date}=${None}
    ${headers}=    Auth Headers    ${access_token}
    ${payload}=    Create Dictionary    description=${description}
    IF    '${due_date}' != '${None}'
        Set To Dictionary    ${payload}    due_date=${due_date}
    END
    ${resp}=       POST On Session    api    ${API_PREFIX}/todo-lists/${todo_list_id}/todos    json=${payload}    headers=${headers}    expected_status=anything
    RETURN       ${resp}

Update Todo Item
    [Arguments]    ${access_token}    ${todo_list_id}    ${todo_item_id}    ${completed}=${None}    ${description}=${None}    ${due_date}=${None}
    ${headers}=    Auth Headers    ${access_token}
    ${payload}=    Create Dictionary    completed=${completed}    description=${description}    due_date=${due_date}
    ${resp}=       PUT On Session    api    ${API_PREFIX}/todo-lists/${todo_list_id}/todos/${todo_item_id}    json=${payload}    headers=${headers}
    RETURN       ${resp}

Delete Todo Item
    [Arguments]    ${access_token}    ${todo_list_id}    ${todo_item_id}
    ${headers}=    Auth Headers    ${access_token}
    ${resp}=       DELETE On Session    api    ${API_PREFIX}/todo-lists/${todo_list_id}/todos/${todo_item_id}    headers=${headers}
    RETURN       ${resp}

Extract Todo Item Id
    [Arguments]    ${resp}
    ${json}=       Set Variable    ${resp.json()}
    ${id}=         Get From Dictionary    ${json}    id
    RETURN       ${id}
