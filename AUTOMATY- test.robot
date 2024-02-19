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

Dashboard MyTasks and MyCases
    Click   ${SEL_HomeTab}

#Moje úkoly - OPEN
    Click    ${SEL_MyTasksCases}
    Match Numbers
    Sleep    0.5S   #Potřebuje čas načíst
    Get Number From String Tasks

    #Dle Termínu
    Click    ${SEL_MyTasksByDeadline}
    Sleep    0.5s
    Get Number From String Tasks

    #Bez Termínu
    Click    ${SEL_MyTasksWithoutDeadline}
    Sleep    0.5s
    Get Number From String Tasks

#Moje úkoly - CLOSED
    Click    ${SEL_MyTasksClosed}
    Click    ${SEL_MyTasksCases}
    Match Numbers
    Sleep    3S   #Potřebuje čas načíst
    Get Number From String Tasks

    #Dle Termínu
    Click    ${SEL_MyTasksByDeadline}
    Sleep    0.5s
    Get Number From String Tasks

    #Bez Termínu
    Click    ${SEL_MyTasksWithoutDeadline}
    Sleep    0.5s
    Get Number From String Tasks




##Sledované Úkoly-------------------------
#
##Dle Případu - OPEN
    Click    ${SEL_MyWatchedTasks}
    Sleep    0.5S   #Potřebuje čas načíst
    Get Number From String Tasks

    ##Dle Termínu
    Click    ${SEL_MyTasksByDeadline}
    Sleep    0.5S   #Potřebuje čas načíst
    Get Number From String Tasks
    ##Bez Termínu
    Click    ${SEL_MyTasksWithoutDeadline}
    Sleep    0.5S   #Potřebuje čas načíst
    Get Number From String Tasks

##Dle Případu - CLOSED
    Click    ${SEL_MyWatchedTasks}
    Click    ${SEL_MyTasksClosed}

    Sleep    0.5S   #Potřebuje čas načíst
    Get Number From String Tasks

    ##Dle Termínu
    Click    ${SEL_MyTasksByDeadline}
    Sleep    0.5S   #Potřebuje čas načíst
    Get Number From String Tasks
    ##Bez Termínu
    Click    ${SEL_MyTasksWithoutDeadline}
    Sleep    0.5S   #Potřebuje čas načíst
    Get Number From String Tasks






#    Click    ${SEL_MyTasksByDeadline}
#    Click    ${SEL_MyTasksOpened}
#    Sleep    2s
#    Get Number From String Tasks
#    Click    ${SEL_MyTasksClosed}
#    Sleep    2s
#    Get Number From String Tasks
#

#
#    Click    ${SEL_MyTasksOpened}
#    Sleep    0.5s
#    Get Number From String Tasks
#    Click    ${SEL_MyTasksClosed}
#    Sleep    0.5s
#    Get Number From String Tasks

test
#OPEN

#    Sleep    2S   #Potřebuje čas načíst
#    Get Number From String Tasks
#    Click    ${SEL_MyTasksByDeadline}
#    Sleep    2S   #Potřebuje čas načíst
#    Get Number From String Tasks
#    Click    ${SEL_MyTasksWithoutDeadline}
#CLOSED
#    Click    ${SEL_MyWatchedTasks}
#    Click    ${SEL_MyTasksClosed}
#
#    Sleep    0.5S   #Potřebuje čas načíst
#    Get Number From String Tasks
#    Click    ${SEL_MyTasksByDeadline}
#    Sleep    0.5S   #Potřebuje čas načíst
#    Get Number From String Tasks
#    Click    ${SEL_MyTasksWithoutDeadline}



#Dashboard MyCases
    Click    ${SEL_MyCases}
    Click    ${SEL_MyCasesClosed}
    Sleep    0.5s   #Potřebuje čas načíst
    Get Number From String Cases
    Click    ${SEL_MyCasesOpened}
    Sleep    0.5s   #Potřebuje čas načíst
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
    ${string}    Get Element    ${SEL_NumberWithStringTasks}
    ${text}    Get Text    ${string}
    ${matches}    Get Regexp Matches    ${text}    \\d+
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

#Filtry pro "Moje Úkoly" a "Sledované úkoly"
${SEL_MyTasks}      xpath=//div[@data-testid="dashboard-tab-list"]//a[@href="/dashboard/my-tasks"]
${SEL_MyWatchedTasks}   xpath=//div[@data-testid="dashboard-tab-list"]//a[@href="/dashboard/watching-tasks"]
#Moje Úkoly
${SEL_MyTasksCases}  xpath=//div[@data-testid="dashboard-task-data-filters"]//button[text()="Dle případu"]
${SEL_MyTasksByDeadline}    xpath=//div[@data-testid="dashboard-task-data-filters"]//button[text()="Dle termínu"]
${SEL_MyTasksWithoutDeadline}   xpath=//div[@data-testid="dashboard-task-data-filters"]//button[text()="Bez termínu"]
${SEL_MyTasksOpened}  xpath=//div[@data-testid="dashboard-task-status-filters"]//button[@value="OPEN"]
${SEL_MyTasksClosed}    xpath=//div[@data-testid="dashboard-task-status-filters"]//button[@value="CLOSED"]
#Sledované úkoly



#Filtry pro "Moje případy" a "Sledované případy"
${SEL_MyCases}  xpath=//div[@data-testid="dashboard-tab-list"]//a[@href="/dashboard/responsible"]
${SEL_MyTrackedCases}   xpath=//div[@data-testid="dashboard-tab-list"]//a[@href="/dashboard/watcher"]
${SEL_MyCasesOpened}  xpath=//div[@data-testid="dashboard-case-status-filters"]//button[@value="CREATED"]
${SEL_MyCasesClosed}    xpath=//div[@data-testid="dashboard-case-status-filters"]//button[@value="CLOSED"]

#Porovnávaní čísel
${SEL_HeaderNumberOfTasks}    data-testid=task-afterDue-count
${SEL_MyTasksNumber}    data-testid=dashboard-tab-my-task-count
${SEL_NumberWithStringTasks}     data-testid=filtered-task-count
#V moment co se klikne na Moje případy tak se změní data-testid
${SEL_NumberWithStringCases}    data-testid=filtered-case-count


#MyTasks --> MyTaskCases ---> MyTasksOpened
