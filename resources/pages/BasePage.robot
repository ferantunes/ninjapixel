*** Settings ***
Documentation   Este arquivo contém as implementações de abertura e fechamento do navegador

*** Variables ***
${BASE_URL}    http://pixel-web:3000

*** Keywords ***
Open session
    Open Chrome
    Set Selenium Implicit Wait    5
    Set Window Size    1280    800

Close session
    Capture Page Screenshot
    Close Browser

Open Chrome
    Open Browser    ${BASE_URL}/login    chrome    options=add_experimental_option('excludeSwitches', ['enable-logging'])