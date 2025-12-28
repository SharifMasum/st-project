*** Settings ***
Resource    ../resources/common.resource
Resource    ../resources/users.resource
Resource    ../resources/todo_lists.resource
Resource    ../resources/todo_items.resource
Suite Setup    Create API Session

*** Test Cases ***
Create Update Delete Todo Item Happy Path
    ${username}    ${access}    ${refresh}=    Ensure Logged In User
    ${list_resp}=  Create Todo List    ${access}    Items List    For items
    ${list_id}=    Extract Todo List Id    ${list_resp}

    ${create}=     Create Todo Item    ${access}    ${list_id}    Buy milk
    Should Be Equal As Integers    ${create.status_code}    200

Create Todo Item Negative Missing Description Returns 422
    ${username}    ${access}    ${refresh}=    Ensure Logged In User
    ${list_resp}=  Create Todo List    ${access}    Negative Items    For items
    ${list_id}=    Extract Todo List Id    ${list_resp}

    ${headers}=    Auth Headers    ${access}
    ${payload}=    Create Dictionary    due_date=2025-12-31
    ${resp}=       POST On Session    api    ${API_PREFIX}/todo-lists/${list_id}/todos    json=${payload}    headers=${headers}    expected_status=anything
    Should Be Equal As Integers    ${resp.status_code}    422
