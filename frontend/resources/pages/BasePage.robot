*** Settings ***
Documentation    Este arquivo contém as implementações de abertura e fechamento do navegador

*** Variables ***
${BASE_URL}    http://pixel-web:3000

*** Keywords ***
Open Session
    Open Chrome
    Set Selenium Implicit Wait    5
    Set Window Size               1280    800

Close session
    Close Browser

After Test
    Capture Page Screenshot

After Test With Clear Local Storage
    Capture Page Screenshot
    Execute Javascript    localStorage.clear();

Login Session
    Open Session
    Login with      fernanda@ninjapixel.com    pwd123

Open Chrome
    Open Browser    ${BASE_URL}/login    chrome    options=add_experimental_option('excludeSwitches', ['enable-logging'])