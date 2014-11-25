@zips
Feature: generate zipped output files

  As a consumer of CSVs
  I want zipped output CSVs

  Background: setup the sample data file
    Given a file named "sample.csv" with:
    """
    "","outcode.len","region.len","outcode.bor","region.bor","loan.id","postcode.bor","originated","maturity","term","loan.part.value","loan.rate","sector","postcode.len","platform","area.len","area.bor","incode.len","incode.bor"
    "1","AAA","Scotland","BBB","North West","0000B535-182A-11E0-9801-0050569D002A","AAABBB",2011-01-05 16:34:53,2016-02-01,60,10,8.04,"Individual","AAACCC","Zopa","AAA","BBB","DDD","CCC"
    "430","AAA","South West","BBB","Wales","0001533F-716C-E111-90C3-0050569D002D","AAABBB",2012-03-13 16:47:15,2015-04-03,36,10,6.41,"Individual","AAACCC","Zopa","AAA","BBB","DDD","CCC"
    """

  @no-postcodes
  Scenario: one without postcodes
    When I successfully run `noodile --zip sample.csv`
    Then a 430 byte file named "outputs/complete.no.postcodes.csv.zip" should exist
    And a file named "outputs/complete.no.postcodes.csv" should not exist
    When I run `unzip -t outputs/complete.no.postcodes.csv.zip`
    Then the output should contain:
    """
    Archive:  outputs/complete.no.postcodes.csv.zip
        testing: complete.no.postcodes.csv   OK
    No errors detected in compressed data of outputs/complete.no.postcodes.csv.zip.
    """

  @borrower
  Scenario: by-borrower files
    When I successfully run `noodile --split-by region.bor --zip sample.csv`
    Then a file named "outputs/by.region.bor.north_west.csv.zip" should exist
    And a file named "outputs/by.region.bor.wales.csv.zip" should exist
    And a file named "outputs/by.region.bor.north_west.csv" should not exist
    When I run `unzip -t outputs/by.region.bor.wales.csv.zip`
    Then the output should contain:
    """
    Archive:  outputs/by.region.bor.wales.csv.zip
        testing: by.region.bor.wales.csv   OK
    No errors detected in compressed data of outputs/by.region.bor.wales.csv.zip.
    """
