*** Settings ***
Documentation    Este arquivo contém as implementações dos steps

Library    libs/db.py
Library    SeleniumLibrary
Library    OperatingSystem

Resource    pages/BasePage.robot
Resource    components/Sidebar.robot
Resource    pages/LoginPage.robot
Resource    pages/ProductPage.robot


*** Keywords ***
### Login
Dado que eu acesso a página de login
    Open session

Quando eu submeto minhas credenciais "${email}" e "${pass}"
    Login with    ${email}    ${pass}

Entao devo ser autenticado
    Wait Until Element Is Visible    ${LOGEED_USER}
    Element Text Should Be           ${LOGEED_USER}    Fernanda

Entao devo ver uma mensagem de alerta "${mensagem_alerta}"
    Wait Until Element Is Visible    css:.alert-dismissible
    Element Text Should Be           css:.alert-dismissible    ${mensagem_alerta}

### Products
Dado que estou logado
    Login with    fernanda@ninjapixel.com    pwd123

Quando eu faço o cadastro desse produto
    [Arguments]    ${json_file}

    Log Variables
    Log   ${EXECDIR}


    ${product_file}=    Get File    resources/fixtures/${json_file}
    ${product_json}=    Evaluate    json.loads($product_file)          json

    Remove Product By Name    ${product_json['name']}
    Create New Product        ${product_json}
    Set Test Variable         ${product_json}

Devo ver este item no catálogo
    Table Should Contain    class:table    ${product_json['name']}
