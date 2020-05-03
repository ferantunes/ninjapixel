*** Settings ***
Documentation    Cadastro de produtos
...       Sendo um administrador de catálogo
...       Quero cadastrar produtos
...       Para que eu possa disponibilizar-los na loja virtual

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