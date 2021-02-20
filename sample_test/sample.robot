*** Settings ***

Resource        cumulusci/robotframework/Salesforce.robot
Library         cumulusci.robotframework.PageObjects

Suite Setup     Open Test Browser
Suite Teardown  Delete Records and Close Browser


*** Test Cases ***

Via UI
    &{account} =    API Create Account
    ${name} =       Generate Random String
    Go To Object Home      CumulusCI_Demo__c
    Click Object Button    New
    Populate Form
    ...                    CumulusCI Demo Name=${name}
    Populate Lookup Field  Account  &{account}[Name]
    Click Modal Button     Save
    Wait Until Modal Is Closed
    ${demo_id} =           Get Current Record Id
    Store Session Record   CumulusCI_Demo__c  ${demo_id}
    Validate Demo          ${demo_id}  ${name}  &{account}


*** Keywords ***

Validate Demo
    [Arguments]          ${demo_id}  ${name}  &{account}
    # Validate via UI
    Go To Record Home    ${demo_id}
    Page Should Contain  ${name}
    Page Should Contain  &{account}[Name]

API Create Account
    ${name} =        Generate Random String
    ${account_id} =  Salesforce Insert  Account
    ...                Name=${name}
    &{account} =     Salesforce Get  Account  ${account_id}
    [return]  &{account}