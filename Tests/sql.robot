*** Settings ***
Library           DatabaseLibrary
Library           OperatingSystem


*** Variables ***
${DBHost}         localhost
${DBName}         DvdTwo
${DBPass}         test
${DBPort}         5432
${DBUser}         test

*** Test Cases ***
setup
    [Documentation]  psycopg2 is the PostgreSQL adaptor for Python: https://pypi.org/project/psycopg2-binary/
    Connect To Database    psycopg2    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}

test get table description
    @{queryResults}	Description	SELECT * FROM film
    Log Many	@{queryResults}

test row count and verify
    ${rowCount}  Row Count  SELECT * FROM film
    Log  ${rowCount}
    should be equal as strings  ${rowCount}  1000

test row count should be
    row count is equal to x  SELECT * FROM category  16

test find 3 actors named Ed
    #Should return 3 Ed's
    @{queryResults}	Query   SELECT * FROM actor WHERE first_name = 'Ed'
    Log Many	@{queryResults}

test Does this Exist in the DB?
    check if exists in database  SELECT name FROM category WHERE name = 'Animation'

test Make sure this doesn't exist in the DB
    check if not exists in database  SELECT name FROM category WHERE name = 'Zombies'
