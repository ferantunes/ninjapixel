*** Settings ***
Documentation    Este arquivo contém as implementações dos steps

Library     SeleniumLibrary

Resource    pages/BasePage.robot
Resource    pages/LoginPage.robot

*** Keywords ***
Dado que eu acesso a página de login
    Open session

Quando eu submeto minhas credenciais "${email}" e "${pass}"
    Login with    ${email}    ${pass}

Entao devo ser autenticado
    Wait Until Page Contains    Papito

Entao devo ver uma mensagem de alerta "${mensagem_alerta}"
    Wait Until Element Is Visible       css:.alert-dismissible
    Element Text Should Be              css:.alert-dismissible       ${mensagem_alerta}