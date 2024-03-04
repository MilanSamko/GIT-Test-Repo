*** Settings ***
Library         Browser
Library         String
Library         XML
Resource        ..//Data/Configuration.robot
Resource        ..//Data/TestData.robot
Resource        ..//Data/Keywords_BL.robot

Suite Setup     Before_suite
Test Setup      Before_test


*** Variables ***
${SEL_HomeTab}                      data-testid=home-tab

#    Filtry pro "Moje Úkoly" a "Sledované úkoly"
${SEL_MyTasks}                      xpath=//div[@data-testid="dashboard-tab-list"]//a[@href="/dashboard/my-tasks"]
${SEL_MyWatchingTasks}              xpath=//div[@data-testid="dashboard-tab-list"]//a[@href="/dashboard/watching-tasks"]

#    Tlačítka Filry
##    Task
${SEL_MyTasksCases}                 xpath=//div[@data-testid="dashboard-task-data-filters"]//button[text()="Dle případu"]

${SEL_MyTasksByDate}                xpath=//div[@data-testid="dashboard-task-data-filters"]//button[text()="Dle termínu"]
${SEL_MyTasksWithoutDate}           xpath=//div[@data-testid="dashboard-task-data-filters"]//button[text()="Bez termínu"]
${SEL_MyTasksOpened}                xpath=//div[@data-testid="dashboard-task-status-filters"]//button[@value="OPEN"]
${SEL_MyTasksClosed}                xpath=//div[@data-testid="dashboard-task-status-filters"]//button[@value="CLOSED"]
##    Cases
${SEL_MyCasesOpened}                xpath=//div[@data-testid="dashboard-case-status-filters"]/button[@value="CREATED"]
${SEL_MyCasesClosed}                xpath=//div[@data-testid="dashboard-case-status-filters"]/button[@value="CLOSED"]

#    Filtry pro "Moje případy" a "Sledované případy"
${SEL_MyCases}                      xpath=//div[@data-testid="dashboard-tab-list"]//a[@href="/dashboard/responsible"]
${SEL_MyWatchedCases}               xpath=//div[@data-testid="dashboard-tab-list"]//a[@href="/dashboard/watcher"]

#    Porovnávaní čísel
${SEL_HeaderNumberOfTasks}          data-testid=task-afterDue-count
${SEL_MyTasksNumber}                data-testid=dashboard-tab-my-task-count
${SEL_NumberOfTasks_String}         data-testid=filtered-task-count

${SEL_NumberOfStringCases}          data-testid=filtered-case-count

#    Počká než se načte list
# ${SEL_ListTasks}    xpath=//div[@class="MuiStack-root css-18zsr3k"]
# ${SEL_ListTasksWatched}    xpath=//div[@class="MuiStack-root css-18zsr3k"]
# namísto těchto selectorů používám lokální proměnnou ze selectorem s proměnnou v rámci klíčového slova

${SEL_ListCases}                    xpath=//div[@class="MuiStack-root css-yqp7p1"]
${SEL_ListCasesWatched}             xpath=//div[@class="MuiStack-root css-yqp7p1"]
${SEL_ListCasesWatchedList}         xpath=//div[@class="MuiStack-root css-yqp7p1"]//a[@date-testid="simple-row-case"]
# ${SEL_ListCasesMyCases}    xpath=//ul[@class="MuiList-root MuiList-padding css-1ontqvh"]
# ${SEL_ListCasesMyCasesClosed}    xpath=//ul[@class="MuiList-root MuiList-padding css-1ontqvh"]
# tyto selectory jsou totožné, je potřeba je sjednotit do jendoho, ideálně bez css třídy, např.
${SEL_ListItemMyCases}              data-testid=simple-list-case

# ${SEL_ListCasesMyWathchedCases}    xpath=//div[@class="MuiStack-root css-yqp7p1"]/nav[@aria-label="pagination navigation"]
#    Drobečková navigace fix
# ${SEL_DashboardBreadcrumbs}    xpath=//li[@class="MuiBreadcrumbs-li"]/div[@data-testid="breadcrumbs-translation-2"]
# jednodušší xpath bez css, název bych použila dle idčka, jedná se totiž o obecný selector napříč aplikací, nejenom na dashboardu, např.
${SEL_BreadcrumbsTranslation2}      xpath=//li/div[@data-testid="breadcrumbs-translation-2"]


*** Test Cases ***
Filters my tasks and cases on dashboard
#    pozměnila bych název scénáře na Filters my tasks and cases on dashboard
    Click    ${SEL_HomeTab}
#    Moje Úkoly-------------------------

#    Moje úkoly - OPENED
#    Dle případu
    Click    ${SEL_MyTasksCases}
    Match Numbers
    Verify count of loaded tasks    Dle případu

#    Dle Termínu
    Click    ${SEL_MyTasksByDate}
    Verify count of loaded tasks    Dle termínu

#    Bez Termínu
    Click    ${SEL_MyTasksWithoutDate}
    Verify count of loaded tasks    Bez termínu

#    Moje úkoly - CLOSED
#    Dle případu
    Click    ${SEL_MyTasksClosed}
    Click    ${SEL_MyTasksCases}
    Verify count of loaded tasks    Dle případu

#    Dle Termínu
    Click    ${SEL_MyTasksByDate}
    Verify count of loaded tasks    Dle termínu

#    Bez Termínu
    Click    ${SEL_MyTasksWithoutDate}
    Verify count of loaded tasks    Bez termínu
    Verify Breadcrumbs Text    Moje úkoly

#    Moje Sledované Úkoly----------------

#    Dle Případu - OPENED
    Click    ${SEL_MyWatchingTasks}
    Wait For Navigation    https://test.eucs.online/dashboard/watching-tasks    wait_until=load
    Click    ${SEL_MyTasksCases}
    Verify count of loaded tasks    Dle případu

#    Dle Termínu
    Click    ${SEL_MyTasksByDate}
    Verify count of loaded tasks    Dle termínu

    ##Bez Termínu
    Click    ${SEL_MyTasksWithoutDate}
    Verify count of loaded tasks    Bez termínu

#    Dle Případu - CLOSED
    Click    ${SEL_MyTasksCases}
    Click    ${SEL_MyTasksClosed}
    Verify count of loaded tasks    Dle případu
#    Dle Termínu
    Click    ${SEL_MyTasksByDate}
    Verify count of loaded tasks    Dle termínu
#    Bez Termínu
    Click    ${SEL_MyTasksWithoutDate}
    Verify count of loaded tasks    Bez termínu
    Verify Breadcrumbs Text    Sledované úkoly

#    Moje Případy--------------------------------------------------------------------------------------------------------
#    Tady se není nic krom list, ten je jediný na který se dá odkazovat při načítáni obsahu "Wait for elements state" , Ten někdy načte ryhle někdy pomalu,
#    to způsobuje že občas test projde občasa ne. Řešeno provizorně pomocí "Sleep"

#    Dashboard MyCases -OPENED

    Click    ${SEL_MyCases}
#    Sleep    3s
    Verify count of loaded tasks    Otevřené
#    Dashboard MyCases -CLOSED
    Click    ${SEL_MyCasesClosed}
#    Sleep    2s
    Wait For Elements State    ${SEL_ListItemMyCases}
    Verify count of loaded tasks    Uzavřené
    Verify Breadcrumbs Text    Moje případy
#    Moje Sledované případy---------------

#    My WathchedCases -OPENED
    Click    ${SEL_MyWatchedCases}
    Sleep    3s    # tady se čeká než se načte stránka a paginace (je tu cca 500 případů)
    Verify count of loaded tasks    Otevřené

#    My WathchedCases -CLOSED
    Click    ${SEL_MyCasesClosed}
#    Sleep    3s
    Verify count of loaded tasks    Uzavřené
    Verify Breadcrumbs Text    Sledované případy


*** Keywords ***
Match Numbers
# pojmenovala bych Keyword konkrétněji - Match the number of cases in the header with the number in the cases tab
#    Porovná čísla v Headru a v Moje úkoly
    ${HeaderNumberOfTasks}    Get Text    ${SEL_HeaderNumberOfTasks}
    Log To Console    ${HeaderNumberOfTasks}
    ${MyTasksNumber}    Get Text    ${SEL_MyTasksNumber}
    Log To Console    ${MyTasksNumber}
#    chybí porovnat proměnné ${HeaderNumberOfTasks} ${MyTasksNumber} jestli jsou stejné - třeba pomocí keyword should be equal, prosím doplnit

#

Verify count of loaded tasks
    [Arguments]    ${NameOfTasksTab}
    ${original_sel_ListItemMyTasks}    Set Variable
    ...    xpath=//div[//button[text()='${NameOfTasksTab}' and @aria-pressed="true"]]//following-sibling::div//input
    ${new_sel_ListItemMyTasks}    Replace String
    ...    ${original_sel_ListItemMyTasks}
    ...    NameOfTasksTab
    ...    ${NameOfTasksTab}
    Log To Console    ${new_sel_ListItemMyTasks}
#    oveřím načtení prvího úkolu v aktuální záložce
    Wait For Elements State    ${new_sel_ListItemMyTasks} >> nth=0    visible
#    ze stringu obsahujícího number + text vytáhnu pouze číslo
    ${string}    Get Text    ${SEL_NumberOfTasks_String}
    ${matches}    Get Regexp Matches    ${string}    \\d+
    ${number}    Set Variable    ${matches}[0]
#    ověřím, že počet není rovný 0
    Should Not Be Equal As Numbers    ${number}    0
#    porovnám počet úkolů s počtem načtených úkolů
    ${ListItemMyTasksByCases}    Get Element Count    ${new_sel_ListItemMyTasks}
    Should Be Equal As Numbers    ${number}    ${ListItemMyTasksByCases}

#    Ověřuje text drobečkové navigace, ta je v kodu vždy až na konci ať se stihne načít správný název.

Verify Breadcrumbs Text
    [Arguments]    ${TextForBreadcrumbs}
    ${Breadcumbstext}    Get Text    ${SEL_BreadcrumbsTranslation2}
    Should Be Equal    ${Breadcumbstext}    ${TextForBreadcrumbs}
    Log To Console    ${Breadcumbstext} Breadcrumbs OK..
