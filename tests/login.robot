*** Settings ***
Documentation       Login
...     Sendo um administrador de catálogo
...     Quero me autenticar no sistema
...     Para que eu possa gerenciar o catálogo de produtos

Library     SeleniumLibrary

Test Teardown      Fecha navegador

*** Variables ***
${EMAIL}                        fernanda@ninjapixel.com
${CAMPO_EMAIL}                  id:emailId
${CAMPO_SENHA}                  id:passId
${BTN_ENTRAR}                   class:btn
${MSG_USR_SENHA_INVALIDO}       css:.alert-dismissible

*** Test Cases ***
Login com sucesso
    Dado que eu acesso a página de login
    Quando eu submeto minhas credenciais "fernanda@ninjapixel.com" e "pwd123"
    Entao devo ser autenticado

Senha incorreta
    Dado que eu acesso a página de login
    Quando eu submeto minhas credenciais com senha incorreta
    Entao devo ver uma mensagem de alerta "Usuário e/ou senha inválidos"

*** Keywords ***
Dado que eu acesso a página de login
    Open Browser    http://pixel-web:3000/login     chrome

Quando eu submeto minhas credenciais "${email}" e "${pass}"
    Input Text      ${CAMPO_EMAIL}      ${email}
    Input Text      ${CAMPO_SENHA}      ${pass}
    Click Element   ${BTN_ENTRAR}

Entao devo ser autenticado
    Wait Until Page Contains    Papito

Quando eu submeto minhas credenciais com senha incorreta
    Input Text      ${CAMPO_EMAIL}      ${EMAIL}
    Input Text      ${CAMPO_SENHA}      abc
    Click Element   ${BTN_ENTRAR}

Entao devo ver uma mensagem de alerta "${mensagem_alerta}"
    Wait Until Element Is Visible       ${MSG_USR_SENHA_INVALIDO}
    Element Text Should Be              ${MSG_USR_SENHA_INVALIDO}       ${mensagem_alerta}

Fecha navegador
    Close Browser