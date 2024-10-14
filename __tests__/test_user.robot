# 1 - Incluir, consultar, alterar e excluir um usuário, sempre com o teste do Status Code 
# e pelo menos 3 testes de campos do retorno.

*** Settings ***
# Bibliotecas e Configurações
Library    RequestsLibrary

*** Variables ***
# Objetos, Atributos e Variables
${url}    https://petstore.swagger.io/v2/user

${id}    117016598
${username}    jo
${firstName}    Usuario
${lastName}    Swagger
${email}    swagger@usuario-edu.com.br
${password}    123456
${phone}    99999999
${userStatus}    1

*** Test Cases ***
Post user

#Montar a mensagem/body
    ${body}    Create Dictionary    id=${id}    username=${username}    firstName=${firstName}    
...                             lastName=${lastName}    email=${email}    password=${password}
...                             phone=${phone}    userStatus=${userStatus}

#Executar
    ${response}    POST    url=${url}    json=${body}

#Validar
    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[code]   ${{int(200)}}    
    Should Be Equal    ${response_body}[type]       unknown
    Should Be Equal    ${response_body}[message]    ${id}

Get user
    ${response}    GET    ${{$URL + '/' + $username}}

    #valida
    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[id]    ${{int($id)}}
    Should Be Equal    ${response_body}[username]     ${username}
    Should Be Equal    ${response_body}[firstName]     ${firstName}
    Should Be Equal    ${response_body}[lastName]     ${lastName}
    Should Be Equal    ${response_body}[email]     ${email}
    Should Be Equal    ${response_body}[password]     ${password}
    Should Be Equal    ${response_body}[phone]     ${phone}
    Should Be Equal    ${response_body}[userStatus]    ${{int($userStatus)}}

Put user
        # Montar a mensagem / body com a mudança
    ${body}    Evaluate    json.loads(open('./fixtures/json/user2.json').read())

    # Executa
    ${response}    PUT    ${{$url + '/' + $username}}    json=${body}

#Validar
    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[code]   ${{int(200)}}    
    Should Be Equal    ${response_body}[type]       unknown
    Should Be Equal    ${response_body}[message]    ${id}

Delete user
    ${response}    DELETE    ${{$URL + '/' + $username}}


    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[code]    ${{int(200)}}  
    Should Be Equal    ${response_body}[type]       unknown
    Should Be Equal    ${response_body}[message]    ${username}

*** Keywords ***
