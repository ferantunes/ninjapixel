*** Settings ***
Documentation    Este arquivo contém as implementações das funções e elementos da página de produtos

*** Keywords ***
Create New Product
    [Arguments]    ${product_json}

    Click Element      class:product-add
    Input Text         css:input[name=title]             ${product_json['name']}
    
    Run Keyword If     '${product_json['cat']}' != 'None'    Select Category    ${product_json['cat']}
    
    Input Text         css:input[name=price]             ${product_json['price']}
    Input Producers    ${product_json['producers']}
    
    Input Text         css:textarea[name=description]    ${product_json['desc']}
    Upload Photo       ${product_json['image']}          
    
    Click Element      id:create-product

Upload Photo
    [Arguments]    ${image}

    ${file}        Set Variable    ${EXECDIR}/resources/fixtures/images/${image}
    Choose File    id:upcover      ${file}

Select Category
    [Arguments]    ${cat}

    Click Element    css:input[placeholder=Gategoria]

    Set Selenium Speed               1
    Wait Until Element Is Visible    class:el-select-dropdown__list
    Click Element                    xpath://li/span[text()='${cat}']
    Set Selenium Speed               0

Input Producers
    [Arguments]    ${producers}

    FOR    ${item}    IN    @{producers}
        Log    ${item}
        Input Text    class:producers    ${item}
        Press Keys    class:producers    TAB
    END

Get Product Json
    [Arguments]    ${file_name}

    ${file}=    Get File    resources/fixtures/${file_name}
    ${json}=    Evaluate    json.loads($file)    json

    [Return]    ${json}