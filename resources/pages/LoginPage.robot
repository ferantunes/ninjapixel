*** Settings ***
Documentation    Este arquivo contém as implementações das funções e elementos da página de login

*** Keywords ***
Login with
    [Arguments]     ${email}    ${pass}

    Input Text       id:emailId    ${email}
    Input Text       id:passId     ${pass}
    Click Element    class:btn
