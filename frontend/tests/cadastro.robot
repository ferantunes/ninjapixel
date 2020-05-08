*** Settings ***
Documentation    Cadastro de produtos
...              Sendo um administrador de catálogo
...              Quero cadastrar produtos
...              Para que eu possa disponibilizar-los na loja virtual

Resource    ../resources/actions.robot

Suite Setup       Login Session
Suite Teardown    Close session

Test Teardown    After Test

*** Test Cases ***
Disponibilizar produto
    Dado que eu tenho um novo produto    dk.json
    Quando eu faço o cadastro desse produto
    Então devo ver este item no catálogo

Produto duplicado
    Dado que eu tenho um novo produto    master.json
    Mas este produto já foi cadastrado
    Quando eu faço o cadastro desse produto
    Então devo ver a mensagem de alerta "Oops - Este produto já foi cadastrado!"

Nome não informado
    [Template]            Tentativa de cadastro
    [Setup]               Click Menu Product
    
    streetFighter.json    Oops - Informe o nome do produto!

Categoria não selecionada
    [Template]     Tentativa de cadastro
    [Setup]        Click Menu Product
    
    golden.json    Oops - Selecione uma categoria!

Preço não informado
    [Template]     Tentativa de cadastro
    [Setup]        Click Menu Product
    
    contra.json    Oops - Informe o preço também!

*** Keywords ***
Tentativa de cadastro
    [Arguments]    ${file_name}    ${expect_message}
    Dado que eu tenho um novo produto    ${file_name}
    Quando eu faço o cadastro desse produto
    Então devo ver a mensagem de alerta "${expect_message}"