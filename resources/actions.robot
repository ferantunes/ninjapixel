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
### Helpers
Get Product Json
    [Arguments]    ${file_name}

    ${file}=    Get File    resources/fixtures/${file_name}
    ${json}=    Evaluate    json.loads($file)                  json

    [Return]    ${json}

### Login
Dado que eu acesso a página de login
    Go To    ${BASE_URL}/login

Quando eu submeto minhas credenciais "${email}" e "${pass}"
    Login with    ${email}    ${pass}

Entao devo ser autenticado
    Wait Until Element Is Visible    ${LOGEED_USER}
    Element Text Should Be           ${LOGEED_USER}    Fernanda

Entao devo ver uma mensagem de alerta "${mensagem_alerta}"
    Wait Until Element Is Visible    css:.alert-dismissible
    Element Text Should Be           css:.alert-dismissible    ${mensagem_alerta}

### Products
Dado que eu tenho um novo produto
    [Arguments]    ${file_name}

    ${product_json}    Get Product Json    ${file_name}

    Remove Product By Name    ${product_json['name']}
    Set Test Variable         ${product_json}

Mas este produto já foi cadastrado
    Create New Product    ${product_json}

Quando eu faço o cadastro desse produto
    Create New Product    ${product_json}

Então devo ver este item no catálogo
    Table Should Contain    class:table    ${product_json['name']}

Então devo ver a mensagem de alerta "${expect_message}"
    Wait Until Element Contains    class:alert-danger    ${expect_message}

### Remover
Dado que eu tenho o produto "${file_name}" no catálogo
    ${product_json}=    Get Product Json    ${file_name}

    Remove Product By Name    ${product_json['name']}
    Create New Product        ${product_json}

    Set Test Variable    ${product_json}

Quando solicito a exclusão
    Click Element    xpath://tr[td//text()[contains(., '${product_json['name']}')]]//button
    Wait Until Element Is Visible    class:swal2-modal

E confirmo a solicitação
    Click Element    class:swal2-confirm

Mas cancelo a solicitação
    Click Element    class:swal2-cancel

Então não devo ver este item no catálogo
    Wait Until Element Does Not Contain    class:table    ${product_json['name']}