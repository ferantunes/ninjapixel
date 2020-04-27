*** Settings ***
Documentation   Este arquivo contém as implementações de abertura e fechamento do navegador

*** Keywords ***
Open session
    Open Browser                  http://pixel-web:3000    chrome
    Set Selenium Implicit Wait    5

Close session
    Close Browser