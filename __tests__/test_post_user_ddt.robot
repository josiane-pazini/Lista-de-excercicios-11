*** Settings ***
Library    RequestsLibrary
Library    DataDriver   ../fixtures/csv/users.csv    dialect=excel
Variables    ../resources/variables.py
Test Template    Post DDT

*** Test Cases ***
TC01
*** Keywords ***

 Post DDT
    [Arguments]    ${id}    ${username}    ${firstName}    ${lastName}    ${email}    ${password}    ${phone}    ${userStatus}
    ${headers}    Create Dictionary    Content-Type=${content_type}
    ${id}    Convert To Integer    ${id}
    ${userStatus}    Convert To Integer    ${userStatus}

    ${body}    Create Dictionary    id=${id}    username=${username}    firstName=${firstName}    
...                             lastName=${lastName}    email=${email}    password=${password}
...                             phone=${phone}    userStatus=${userStatus}

#Executar
    ${response}    POST    url=${url}/user    headers=${headers}    json=${body}

#Validar
    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[code]    ${{int(200)}}    
    Should Be Equal    ${response_body}[type]       unknown
    Should Be Equal    ${response_body}[message]    ${id}