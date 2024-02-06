*** Settings ***
Library    Browser
Library     OperatingSystem
*** Test Cases ***
Open YouTube

    Open Browser    https://www.youtube.com    browser=chromium
    Click    xpath=//span[text()="Přijmout vše"] 
    Click     xpath=//input[@id='search']
    Type Text     xpath=//input[@id='search']      MCSENA GRT
    Keyboard Key    press    Enter
    Click    xpath=//ytd-video-renderer[1]
    Click    xpath=//*[@id="movie_player"]//button[9]
    Sleep    15s
    Close Browser


*** Keywords ***

