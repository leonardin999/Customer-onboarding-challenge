*** Settings ***
Documentation       The robot uses the RPA.Browser.Playwright library for browser automation,
...                 RPA.HTTP library for downloading the CSV file used in the challenge
...                 RPA.Tables library for reading the CSV into a table data structure.

Library             RPA.HTTP
Library             RPA.Browser.Playwright
Library             RPA.Tables


*** Variables ***
${WEB_URL}      https://developer.automationanywhere.com/challenges/automationanywherelabs-customeronboarding.html
${CSV_PATH}     ${OUTPUT_DIR}${/}customers.csv


*** Tasks ***
Complete Customer Onboarding Challenge
    Open The Challenge Website
    ${customers}=    Get Customers List
    FOR    ${customer}    IN    @{customers}
        Fill and submit customer info    ${customer}
    END
    Take a screenshot of the result
    [Teardown]    Close Browser


*** Keywords ***
Open The Challenge Website
    New Context    userAgent=Chrome\104.0.5112.102
    New Page    ${WEB_URL}

Get Customers List
    [Documentation]    Download the customer.csv files to extract information
    ${download_url}=    Get Attribute    css:p.lead a    href
    RPA.HTTP.Download    ${download_url}    ${CSV_PATH}    overwrite=${True}
    ${customers}=    Read table from CSV    ${CSV_PATH}
    RETURN    ${customers}

Fill and submit customer info
    [Documentation]    insert anotaiontion here
    [Arguments]    ${customer}
    Fill Text    css=#customerName    ${customer}[Company Name]
    Fill Text    css=#customerID    ${customer}[Customer ID]
    Fill Text    css=#primaryContact    ${customer}[Primary Contact]
    Fill Text    css=#street    ${customer}[Street Address]
    Fill Text    css=#city    ${customer}[City]
    Fill Text    css=#zip    ${customer}[Zip]
    Fill Text    css=#email    ${customer}[Email Address]
    Select Options By    css=#state    value    ${customer}[State]
    IF    "${customer}[Offers Discounts]" == "YES"
        Check Checkbox    css=#activeDiscountYes
    ELSE
        Check Checkbox    css=#activeDiscountNo
    END
    IF    "${customer}[Non-Disclosure On File]" == "YES"
        Check Checkbox    css=#NDA
    END
    Click    css=#submit_button    force=True    noWaitAfter=True

Take a screenshot of the result
    Take Screenshot
    ...    filename=${OUTPUT_DIR}${/}result.png
    ...    selector=css=.modal-content
