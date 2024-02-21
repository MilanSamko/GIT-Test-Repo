*** Settings ***
Documentation
Library     Browser
Library     String

Resource    ../Data/Configuration.robot
Resource    ../Data/TestData.robot
Resource    ../Data/Keywords_BL.robot

Suite Setup       Before_suite
Test Setup        Before_test

*** Test Cases ***

Dashboard MyTasks and MyCases
    Click   ${SEL_HomeTab}
#   Moje Úkoly----------------------------------------------------------------------------------------------------------
#
#   Moje úkoly - OPENED
#   Dle případu
    Click    ${SEL_MyTasksCases}

    Match Numbers
    Wait For Elements State    ${SEL_ListTasks}
    Get Number From String Tasks

#   Dle Termínu
    Click    ${SEL_MyTasksByDeadline}
    Wait For Elements State    ${SEL_ListTasks}
    Get Number From String Tasks

#   Bez Termínu
    Click    ${SEL_MyTasksWithoutDeadline}
    Wait For Elements State    ${SEL_ListTasks}
    Get Number From String Tasks

#   Moje úkoly - CLOSED
#   Dle případu
    Click    ${SEL_MyTasksClosed}
    Click    ${SEL_MyTasksCases}
    Wait For Elements State    ${SEL_ListTasks}
    Get Number From String Tasks

#   Dle Termínu
    Click    ${SEL_MyTasksByDeadline}
    Wait For Elements State    ${SEL_ListTasks}
    Get Number From String Tasks

#   Bez Termínu
    Click    ${SEL_MyTasksWithoutDeadline}
    Wait For Elements State    ${SEL_ListTasks}
    Get Number From String Tasks
    Verify Breadcrumbs Text     Moje úkoly

#   Moje Sledované Úkoly------------------------------------------------------------------------------------------------

#   Dle Případu - OPENED
    Click    ${SEL_MyWatchingTasks}
    Wait For Navigation    https://test.eucs.online/dashboard/watching-tasks    wait_until=load
    Click    ${SEL_MyTasksCases}
    Wait For Elements State    ${SEL_ListTasksWatched}
    Get Number From String Tasks

#   Dle Termínu
    Click    ${SEL_MyTasksByDeadline}
    Wait For Elements State    ${SEL_ListTasksWatched}
    Get Number From String Tasks

    ##Bez Termínu
    Click    ${SEL_MyTasksWithoutDeadline}
    Wait For Elements State    ${SEL_ListTasksWatched}
    Get Number From String Tasks

#   Dle Případu - CLOSED
    Click    ${SEL_MyTasksCases}
    Click    ${SEL_MyTasksClosed}
    Wait For Elements State    ${SEL_ListTasksWatched}
    Get Number From String Tasks

#   Dle Termínu
    Click    ${SEL_MyTasksByDeadline}
    Wait For Elements State    ${SEL_ListTasksWatched}
    Get Number From String Tasks

#   Bez Termínu
    Click    ${SEL_MyTasksWithoutDeadline}
    Wait For Elements State    ${SEL_ListTasksWatched}
    Get Number From String Tasks
    Verify Breadcrumbs Text     Sledované úkoly

#   Moje Případy--------------------------------------------------------------------------------------------------------
#   Tady se není nic krom list, ten je jediný na který se dá odkazovat při načítáni obsahu "Wait for elements state" ,   Ten někdy načte ryhle někdy pomalu,
#   to způsobuje že občas test projde občasa ne. Řešeno provizorně pomocí "Sleep 2s"
#   POZN. Mužu do Wait For Elements State dát více SEL_ektorů ? V jaké závislosti se bude hodnotit stav selektoru.

#   Dashboard Moje případy -OPENED

    Click    ${SEL_MyCases}
    Sleep    2s
    Get Number From String Cases

#   Dashboard Moje případy -CLOSED
    Click    ${SEL_MyCasesClosed}
    Sleep    2s
    Get Number From String Cases
    Verify Breadcrumbs Text     Moje případy
#   Sledované případy----------------------------------------------------------------------------------------------

#   My WathchedCases -OPENED
    Click    ${SEL_MyWatchedCases}
    Wait For Elements State    ${SEL_ListCasesMyWathchedCases}
    Get Number From String Cases

#   My WathchedCases -CLOSED
    Click    ${SEL_MyCasesClosed}
    Verify Breadcrumbs Text     Sledované případy
    Get Number From String Cases



*** Keywords ***
Match Numbers
#   Porovná čísla v Headru a v Moje úkoly
    ${HeaderNumberOfTasks}    Get Text    ${SEL_HeaderNumberOfTasks}
    Log To Console    ${HeaderNumberOfTasks}
    ${MyTasksNumber}    Get Text    ${SEL_MyTasksNumber}
    Log To Console    ${MyTasksNumber}

#   Porovná string s 0
Get Number From String Tasks

    ${string}   Get Text    ${SEL_NumberOfStringTasks}
    ${matches}    Get Regexp Matches    ${string}    \\d+
    ${number}    Set Variable    ${matches}[0]
    Log To Console      ${number}
    Should Not Be Equal As Numbers    ${number}    0

Get Number From String Cases
#    Sleep    2s ---- alternativní možnost
    ${string}   Get Text    ${SEL_NumberOfStringCases}
    ${matches}    Get Regexp Matches    ${string}    \\d+
    ${number}    Set Variable    ${matches}[0]
    Log To Console      ${number}
    Should Not Be Equal As Numbers    ${number}    0


#   Ověřuje text drobečkové navigace, ta je v kodu vždy až na konci ať se stihne načít správný název.
Verify Breadcrumbs Text
    [Arguments]    ${TextForBreadcrumbs}
    ${Breadcumbstext}    Get Text   ${SEL_DashBoardBreadcrumbs}
    Should Be Equal   ${Breadcumbstext}       ${TextForBreadcrumbs}
    Log To Console     Breadcrumbs Status OK... ${Breadcumbstext}


*** Variables ***
${SEL_HomeTab}     data-testid=home-tab

#   Filtry pro "Moje Úkoly" a "Sledované úkoly"
${SEL_MyTasks}      xpath=//div[@data-testid="dashboard-tab-list"]//a[@href="/dashboard/my-tasks"]
${SEL_MyWatchingTasks}   xpath=//div[@data-testid="dashboard-tab-list"]//a[@href="/dashboard/watching-tasks"]

#   Tlačítka Filry
##   Task
${SEL_MyTasksCases}  xpath=//div[@data-testid="dashboard-task-data-filters"]//button[text()="Dle případu"]
${SEL_MyTasksByDeadline}    xpath=//div[@data-testid="dashboard-task-data-filters"]//button[text()="Dle termínu"]
${SEL_MyTasksWithoutDeadline}   xpath=//div[@data-testid="dashboard-task-data-filters"]//button[text()="Bez termínu"]
${SEL_MyTasksOpened}  xpath=//div[@data-testid="dashboard-task-status-filters"]//button[@value="OPEN"]
${SEL_MyTasksClosed}    xpath=//div[@data-testid="dashboard-task-status-filters"]//button[@value="CLOSED"]
##   Cases
${SEL_MyCasesOpened}  xpath=//div[@data-testid="dashboard-case-status-filters"]/button[@value="CREATED"]
${SEL_MyCasesClosed}    xpath=//div[@data-testid="dashboard-case-status-filters"]/button[@value="CLOSED"]

#   Filtry pro "Moje případy" a "Sledované případy"
${SEL_MyCases}  xpath=//div[@data-testid="dashboard-tab-list"]//a[@href="/dashboard/responsible"]
${SEL_MyWatchedCases}   xpath=//div[@data-testid="dashboard-tab-list"]//a[@href="/dashboard/watcher"]

#   Porovnávaní čísel
${SEL_HeaderNumberOfTasks}    data-testid=task-afterDue-count
${SEL_MyTasksNumber}    data-testid=dashboard-tab-my-task-count
${SEL_NumberOfStringTasks}     data-testid=filtered-task-count
${SEL_NumberOfStringCases}    data-testid=filtered-case-count

#   Počká než se načte list
${SEL_ListTasks}    xpath=//div[@class="MuiStack-root css-18zsr3k"]
${SEL_ListTasksWatched}  xpath=//div[@class="MuiStack-root css-18zsr3k"]
${SEL_ListCases}     xpath=//div[@class="MuiStack-root css-yqp7p1"]
${SEL_ListCasesWatched}     xpath=//div[@class="MuiStack-root css-yqp7p1"]
${SEL_ListCasesWatchedList}    xpath=//div[@class="MuiStack-root css-yqp7p1"]  #class="MuiStack-root css-yqp7p1"
${SEL_ListCasesMyCases}        xpath=//ul[@class="MuiList-root MuiList-padding css-1ontqvh"]
${SEL_ListCasesMyCasesClosed}   xpath=//ul[@class="MuiList-root MuiList-padding css-1ontqvh"]
${SEL_ListCasesMyWathchedCases}   xpath=//div[@class="MuiStack-root css-yqp7p1"]/nav[@aria-label="pagination navigation"]

#   Drobečková navigace fix
${SEL_DashboardBreadcrumbs}    xpath=//li[@class="MuiBreadcrumbs-li"]/div[@data-testid="breadcrumbs-translation-2"]

