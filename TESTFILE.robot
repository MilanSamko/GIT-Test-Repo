*** Settings ***
Documentation
Library  Browser
Library     String

Resource    Data/Configuration.robot
Resource    Data/TestData.robot
Resource    Data/Keywords_BL.robot

Suite Setup       Before_suite
Test Setup        Before_test


*** Test Cases ***

Dashboard MyTasks and MyCases
    Click   ${SEL_HomeTab}
    Click    ${SEL_MyTasksCases}
    Match Numbers
    Wait For Elements State
#   nejde sleep vyřešit lépe skrz keyword Wait For Elements State?

    Get Number From String Tasks
    Click    ${SEL_MyTasksClosed}
    Get Number From String Tasks


    Click    ${SEL_MyTasksByDeadline}
    Click    ${SEL_MyTasksOpened}
    Get Number From String Tasks
    Click    ${SEL_MyTasksWithoutDeadline}
    Click    ${SEL_MyTasksClosed}
    Get Number From String Tasks



    #Dashboard MyCases
    Click    ${SEL_MyCases}
    Click    ${SEL_MyCasesOpened}
    Sleep    0.5s
    Get Number From String Cases
    Click    ${SEL_MyCasesClosed}
    Get Number From String Cases











*** Keywords ***
Match Numbers
    #Porovná čísla v Headru a v Moje úkoly
    ${HeaderNumberOfTasks}    Get Text    ${SEL_HeaderNumberOfTasks}
    Log To Console    ${HeaderNumberOfTasks}
    ${MyTasksNumber}    Get Text    ${SEL_MyTasksNumber}
    Log To Console    ${MyTasksNumber}


#Porovná čísla úkolů u kterých je i string,najde všechny číselné výrazy, vezme první číselný výraz a porovná ho s 0
Get Number From String Tasks

    ${string}    Get Text    ${SEL_NumberWithStringTasks}
#   POZN.řádek 65 je podle mě zbytečný, pokud jsi chtěl ověřit, že je element ${SEL_NumberWithStringTasks} na stránce pak nemusíš ukládat do proměnné
#   POZN. nechápu proč proměnnou ${string} ukládáš do proměnné ${text}
    ${matches}    Get Regexp Matches    ${string}    \\d+
    ${number}    Set Variable    ${matches}[0]
    Log    ${number}
    Should Not Be Equal As Numbers    ${number}    0


Get Number From String Cases
    ${string}    Get Element    ${SEL_NumberWithStringCases}
    ${text}    Get Text    ${string}
    ${matches}    Get Regexp Matches    ${text}    \\d+
    ${number}    Set Variable    ${matches}[0]
    Log    ${number}
    Should Not Be Equal As Numbers    ${number}    0


*** Variables ***
${SEL_HomeTab}     xpath=//*[@data-testid="home-tab"]

#Filtry pro "Moje ůkoly" a "Sledované úkoly"
${SEL_MyTasks}      xpath=//div[@data-testid="dashboard-tab-list"]//a[@href="/dashboard/my-tasks"]
${SEL_MyWatchedTasks}   xpath=//div[@data-testid="dashboard-tab-list"]//a[@href="/dashboard/watching-tasks"]
${SEL_MyTasksCases}  xpath=//div[@data-testid="dashboard-task-data-filters"]//button[text()="Dle případu"]
#POZN. pojmenovala bych výše uvedený selector spíše ${SEL_MyTasksByCases}
${SEL_MyTasksByDeadline}    xpath=//div[@data-testid="dashboard-task-data-filters"]//button[text()="Dle termínu"]
${SEL_MyTasksWithoutDeadline}   xpath=//div[@data-testid="dashboard-task-data-filters"]//button[text()="Bez termínu"]
${SEL_MyTasksOpened}  xpath=//div[@data-testid="dashboard-task-status-filters"]//button[@value="OPEN"]
${SEL_MyTasksClosed}    xpath=//div[@data-testid="dashboard-task-status-filters"]//button[@value="CLOSED"]
#POZN. zkontroluj xpathy, protože někde máš zbytečně dvě lomítka, když se jedná o přímého potomka, např. xpath u selectoru výše, stačilo by takto: //div[@data-testid="dashboard-task-status-filters"]/button[@value="CLOSED"]
#Filtry pro "Moje případy" a "Sledované případy"
${SEL_MyCases}  xpath=//div[@data-testid="dashboard-tab-list"]//a[@href="/dashboard/responsible"]
${SEL_MyTrackedCases}   xpath=//div[@data-testid="dashboard-tab-list"]//a[@href="/dashboard/watcher"]
#POZN. pojmenovala bych výše uvedený selector spíše ${SEL_MyWatchedCases} abychom dodrželi jednotné názvosloví s ${SEL_MyWatchedTasks}
${SEL_MyCasesOpened}  xpath=//div[@data-testid="dashboard-case-status-filters"]//button[@value="CREATED"]
${SEL_MyCasesClosed}    xpath=//div[@data-testid="dashboard-case-status-filters"]//button[@value="CLOSED"]

#Porovnávaní čísel
${SEL_HeaderNumberOfTasks}    data-testid=task-afterDue-count
${SEL_MyTasksNumber}    data-testid=dashboard-tab-my-task-count
${SEL_NumberWithStringTasks}     data-testid=filtered-task-count
#V moment co se klikne na Moje případy tak se změní data-testid
${SEL_NumberWithStringCases}    data-testid=filtered-case-count
#POZN. nedává mi smysl ten název proměnné, String může obsahovat number,ale number aby obsahoval string?


#MyTasks --> MyTaskCases ---> MyTasksOpened
