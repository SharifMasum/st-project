*** Settings ***
Resource    ../resources/common.resource
Resource    ../resources/users.resource
Resource    ../resources/todo_lists.resource
Suite Setup    Create API Session

*** Test Cases ***
Create Todo List Happy Path
    ${username}    ${access}    ${refresh}=    Ensure Logged In User
    ${resp}=    Create Todo List    ${access}    My List    Description
    Should Be Equal As Integers    ${resp.status_code}    200
    ${id}=      Extract Todo List Id    ${resp}
    Should Be True    ${id} > 0

Create Todo List Negative Missing Name Returns 422
    ${username}    ${access}    ${refresh}=    Ensure Logged In User
    ${headers}=     Auth Headers    ${access}
    ${payload}=     Create Dictionary    description=No name
    ${resp}=        POST On Session    api    ${API_PREFIX}/todo-lists/    json=${payload}    headers=${headers}    expected_status=anything
    Should Be Equal As Integers    ${resp.status_code}    422

Find Todo Lists Happy Path
    ${username}    ${access}    ${refresh}=    Ensure Logged In User
    Create Todo List    ${access}    List A    Desc
    ${resp}=    Find Todo Lists    ${access}
    Should Be Equal As Integers    ${resp.status_code}    200

Update Todo List Happy Path
    ${username}    ${access}    ${refresh}=    Ensure Logged In User
    ${create}=    Create Todo List    ${access}    Old Name    Old Desc
    ${list_id}=   Extract Todo List Id    ${create}
    ${resp}=      Update Todo List    ${access}    ${list_id}    New Name    New Desc
    Should Be Equal As Integers    ${resp.status_code}    200

Update Todo List Negative Missing Body Returns 422
    ${username}    ${access}    ${refresh}=    Ensure Logged In User
    ${create}=    Create Todo List    ${access}    Temp    Temp
    ${list_id}=   Extract Todo List Id    ${create}
    ${headers}=   Auth Headers    ${access}
    ${resp}=      PUT On Session    api    ${API_PREFIX}/todo-lists/${list_id}    headers=${headers}    expected_status=anything
    Should Be Equal As Integers    ${resp.status_code}    422
