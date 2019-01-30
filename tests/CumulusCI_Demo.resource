*** Settings ***

Resource  cumulusci/robotframework/Salesforce.robot

*** Keywords ***

API Create Account
    ${name} =        Generate Random String
    ${account_id} =  Salesforce Insert  Account
    ...                Name=${name}
    &{account} =     Salesforce Get  Account  ${account_id}
    [return]  &{account} 
