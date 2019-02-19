*** Settings ***

Resource        tests/CumulusCI_Demo.resource
Suite Setup     Open Test Browser
Suite Teardown  Delete Records and Close Browser

*** Test Cases ***

Via API
    &{account} =    API Create Account
    ${name} =       Generate Random String
    ${demo_id} =    Salesforce Insert  CumulusCI_Demo__c
    ...               Name=${name}
    ...               Account__c=&{account}[Id]
    &{demo} =       Salesforce Get  CumulusCI_Demo__c  ${demo_id}
    Validate Demo   ${demo_id}  ${name}  &{account}

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
    # Validate via API
    &{demo} =     Salesforce Get  CumulusCI_Demo__c  ${demo_id}
    Should Be Equal  ${name}  &{demo}[Name]
    Should Be Equal  &{account}[Id]  &{demo}[Account__c]
