*** Settings ***
Documentation
Library  Browser
Library     String

Resource    ../Data/Configuration.robot
Resource    ../Data/TestData.robot
Resource    ../Data/Keywords_BL.robot

Suite Setup       Before_suite
Test Setup        Before_test


*** Test Cases ***

Dashboard MyTasks
    Click   ${SEL_HomeTab}
    Click    ${SEL_MyTasksCases}
    Sleep    1s
    Click    ${SEL_MyTasksByDeadline}
    Sleep    1s
    Click    ${SEL_MyTasksWithoutDeadline}
    Sleep    1s
    Click    ${SEL_MyTasksOpened}
    Sleep    1s
    Click    ${SEL_MyTasksClosed}
    Sleep    1s

Dashboard MyCases
    Click    ${SEL_MyCases}
    Sleep    1s
    Click    ${SEL_MyCasesClosed}
    Sleep    1s
    Click    ${SEL_MyCasesOpened}







Match Numbers
    #Porovná čísla v Headru a v Moje úkoly
    ${HeaderNumberOfTasks}    Get Text    ${SEL_HeaderNumberOfTasks}
    Log To Console    ${HeaderNumberOfTasks}
    ${MyTasksNumber}    Get Text    ${SEL_MyTasksNumber}
    Log To Console    ${MyTasksNumber}
    Should Be Equal    ${HeaderNumberOfTasks}    ${MyTasksNumber}
    #Porovná čísla úkolů u kterých je i string, zpracovává i filtry.






*** Keywords ***



*** Variables ***
${SEL_HomeTab}     xpath=//*[@data-testid="home-tab"]

#Filtry pro "Moje ůkoly" a "Sledované úkoly"
${SEL_MyTasks}      xpath=//div[@data-testid="dashboard-tab-list"]//a[@href="/dashboard/my-tasks"]
${SEL_MyWatchedTasks}   xpath= //div[@data-testid="dashboard-tab-list"]//a[@href="/dashboard/watching-tasks"]
${SEL_MyTasksCases}  xpath=//div[@data-testid="dashboard-task-data-filters"]//button[text()="Dle případu"]
${SEL_MyTasksByDeadline}    xpath=//div[@data-testid="dashboard-task-data-filters"]//button[text()="Dle termínu"]
${SEL_MyTasksWithoutDeadline}   xpath=//div[@data-testid="dashboard-task-data-filters"]//button[text()="Bez termínu"]
${SEL_MyTasksOpened}  xpath=//div[@data-testid="dashboard-task-status-filters"]//button[@value="OPEN"]
${SEL_MyTasksClosed}    xpath=//div[@data-testid="dashboard-task-status-filters"]//button[@value="CLOSED"]

#Filtry pro "Moje případy" a "Sledované případy"
${SEL_MyCases}  xpath=//div[@data-testid="dashboard-tab-list"]//a[@href="/dashboard/responsible"]
${SEL_MyTrackedCases}   xpath=//div[@data-testid="dashboard-tab-list"]//a[@href="/dashboard/watcher"]
${SEL_MyCasesOpened}  xpath=//div[@data-testid="dashboard-case-status-filters"]//button[@value="CREATED"]
${SEL_MyCasesClosed}    xpath=//div[@data-testid="dashboard-case-status-filters"]//button[@value="CLOSED"]

#Porovnávaní čísel
## header number = data-testid="task-afterDue-count"
## my tasks number = data-testid="dashboard-tab-my-task-count"
## NUm_WithString
${SEL_HeaderNumberOfTasks}    data-testid=task-afterDue-count
${SEL_MyTasksNumber}    data-testid=dashboard-tab-my-task-count



