*** Settings ***
Documentation       The robot uses the RPA.Browser.Playwright library for browser automation,
...                 RPA.HTTP library for downloading the CSV file used in the challenge
...                 RPA.Tables library for reading the CSV into a table data structure.

Library             RPA.HTTP
Library             RPA.Browser.Playwright


*** Variables ***
${WEB_URL}      https://developer.automationanywhere.com/challenges/automationanywherelabs-customeronboarding.html
${CSV_PATH}     ${OUTPUT_DIR}${/}customers.csv


*** Tasks ***
Minimal task
    Log    Done.
