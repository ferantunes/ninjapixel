*** Settings ***
Documentation    Este arquivo faz o encapsulamento de algumas chamadas de serviços

Resource   credentials.robot

Library    RequestsLibrary
Library    Collections
Library    OperatingSystem
Library    DatabaseLibrary

Library    libs/db.py

***Keywords***
### Helpers
Get Json
    [Arguments]    ${json_file}

    ${file}=    Get File    ${EXECDIR}/resources/fixtures/${json_file}
    ${json}=    evaluate    json.loads($file)                             json

    [return]    ${json}

### Keywords
Get Auth Token
    [Arguments]    ${email}    ${pass}

    ${resp}=    Post Token           ${email}                   ${pass}
    ${token}    Convert To String    ${resp.json()['token']}

    [return]    ${token}

Post Token
    [Arguments]    ${email}    ${pass}

    Create Session    pixel    http://pixel-api:3333

    &{payload}=    Create Dictionary    email=${email}                   password=${pass}
    &{headers}=    Create Dictionary    Content-Type=application/json

    ${resp}=    Post Request    pixel    /auth    data=${payload}    headers=${headers}

    [return]    ${resp}

Post Product
    [Arguments]    ${payload}    ${token}

    &{headers}=    Create Dictionary    Content-Type=application/json    Authorization=JWT ${token}

    ${resp}=    Post Request    pixel    /products    data=${payload}    headers=${headers}

    [return]    ${resp}

Get Product
    [Arguments]    ${id}    ${token}

    Create Session    pixel    http://pixel-api:3333

    &{headers}=    Create Dictionary    Content-Type=application/json    Authorization=JWT ${token}

    ${resp}    Get Request    pixel    /products/${id}    headers=${headers}

    [return]    ${resp}

Delete Product
    [Arguments]    ${id}    ${token}

    Create Session    pixel    http://pixel-api:3333

    &{headers}=    Create Dictionary    Content-Type=application/json    Authorization=JWT ${token}

    ${resp}    Delete Request    pixel    /products/${id}    headers=${headers}

    [return]    ${resp}