*** Settings ***
Documentation    Login
...     Sendo um administrador de catálogo
...     Quero me autenticar no sistema
...     Para que eu possa gerenciar o catálogo de produtos

Resource    ../resources/actions.robot
Resource    ../resources/pages/BasePage.robot

Test Teardown    Close session

*** Test Cases ***
Login com sucesso
    Dado que eu acesso a página de login
    Quando eu submeto minhas credenciais "fernanda@ninjapixel.com" e "pwd123"
    Entao devo ser autenticado

Senha incorreta
    [Template]    Tentativa de login
    fernanda@ninjapixel.com     abc     Usuário e/ou senha inválidos

E-mail não existe
    [Template]    Tentativa de login
    404@ig.com     pwd123     Usuário e/ou senha inválidos

E-mail obrigatório
    [Template]    Tentativa de login
    ${EMPTY}     pwd123     Opps. Informe o seu email!

Senha obrigatória
    [Template]    Tentativa de login
    fernanda@ninjapixel.com     ${EMPTY}     Opps. Informe a sua senha!

*** Keywords ***
Tentativa de login
    [Arguments]     ${email}    ${pass}    ${mensagem_alerta}

    Dado que eu acesso a página de login
    Quando eu submeto minhas credenciais "${email}" e "${pass}"
    Entao devo ver uma mensagem de alerta "${mensagem_alerta}"