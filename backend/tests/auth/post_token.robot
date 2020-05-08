***Settings***
Documentation    Testes da Rota /auth da Pixel Api

Resource    ../../resources/services.robot

***Test Cases***
Request Token
    ${resp}=    Post Token    ${USER_AUTH}    ${PASSWORD_AUTH}

    Status Should Be    200    ${resp}

Incorrect password
    ${resp}=    Post Token    ${USER_AUTH}    acb123

    Status Should Be    401    ${resp}