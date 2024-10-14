# 2 - Incluir, consultar e excluir um pedido de compra, sempre com o teste do Status Code 
# e pelo menos 3 testes de campos do retorno.

*** Settings ***
# Bibliotecas e Configurações
Library    RequestsLibrary

*** Variables ***
# Objetos, Atributos e Variables
${url}    https://petstore.swagger.io/v2/store/order
${id}     1
${petId}     117659801
${quantity}    1
${status}    placed


*** Test Cases ***

Post store
    ${body}    Create Dictionary       id=${id}    petId=${petId}    quantity=${quantity}    status=${status}

    ${response}    POST    url=${url}    json=${body}

    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[id]               ${{int($id)}}
    Should Be Equal    ${response_body}[petId]    ${{int($petId)}}
    Should Be Equal    ${response_body}[quantity]    ${{int($quantity)}}
    Should Be Equal    ${response_body}[status]    ${status}

Get store
    ${response}    GET    ${{$url + '/' + $id}}

    #Validar
    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}
    Status Should Be    200
    Should Be Equal    ${response_body}[id]               ${{int($id)}}
    Should Be Equal    ${response_body}[petId]    ${{int($petId)}}
    Should Be Equal    ${response_body}[quantity]    ${{int($quantity)}}
    Should Be Equal    ${response_body}[status]    ${status}

Delete store
        # Executa
    ${response}    DELETE    ${{$url + '/' + $id}}

    # Valida
    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[code]       ${{int(200)}} 
    Should Be Equal    ${response_body}[type]       unknown 
    Should Be Equal    ${response_body}[message]    ${id}  
