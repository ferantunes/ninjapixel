*** Settings ***
Documentation    Cadastro de produtos
...       Sendo um administrador de catálogo
...       Quero cadastrar produtos
...       Para que eu possa disponibilizar-los na loja virtual

Resource    ../resources/actions.robot

Test Setup       Open session
Test Teardown    Close session

*** Test Cases ***
Disponibilizar produto
    Dado que estou logado
    Quando eu faço o cadastro desse produto     dk.json
    Devo ver este item no catálogo