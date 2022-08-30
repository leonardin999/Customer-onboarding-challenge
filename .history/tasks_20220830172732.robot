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
    Log    Done.

Open The Challenge Website
    New Context    userAgent=Chrome\104.0.5112.102
    New Page    ${WEB_URL}

Get Customers List
    [Documentation]    Download the customer.csv files to extract information
    ${download_url}=    Get Attribute    css:p.lead a    href
    RPA.HTTP.Download    ${download_url}    ${CSV_PATH}    overwrite=${True}
    ${customers}=    Read table from CSV    ${CSV_PATH}
    RETURN    ${customers}
