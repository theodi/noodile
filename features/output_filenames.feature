@filenames
Feature: generate correctly-named output files

  As a consumer of CSVs
  I want correctly-named output CSVs

  Background: setup the sample data file
    Given a file named "sample.csv" with:
    """
    "","outcode.len","region.len","outcode.bor","region.bor","loan.id","postcode.bor","originated","maturity","term","loan.part.value","loan.rate","sector","postcode.len","platform","area.len","area.bor","incode.len","incode.bor"
    "1","AAA","Scotland","BBB","North West","0000B535-182A-11E0-9801-0050569D002A","BBBCCC",2011-01-05 16:34:53,2016-02-01,60,10,8.04,"Individual","AAADDD","Zopa","AAA","BBB","DDD","CCC"
    "410","AAA","South West","BBB","Wales","0001533F-716C-E111-90C3-0050569D002D","BBBCCC",2012-03-13 16:47:15,2015-04-03,36,10,6.41,"Individual","AAADDD","Zopa","AAA","BBB","DDD","CCC"
    """

  @everything
  Scenario: one with everything
    When I successfully run `noodile --no-purge-postcodes sample.csv`
    Then a file named "outputs/complete.csv" should exist

  @no-postcodes
  Scenario: one without postcodes
    When I successfully run `noodile sample.csv`
    Then a file named "outputs/complete.no.postcodes.csv" should exist

  @borrower
  Scenario: by-borrower files
    When I successfully run `noodile --split-by region.bor sample.csv`
    Then a file named "outputs/by.region.bor.north_west.csv" should exist
    And a file named "outputs/by.region.bor.wales.csv" should exist
    And a file named "outputs/by.region.bor.region.bor.csv" should not exist

  @lender
  Scenario: by-lender files
    When I successfully run `noodile --split-by region.len sample.csv`
    Then a file named "outputs/by.region.len.scotland.csv" should exist
    And a file named "outputs/by.region.len.south_west.csv" should exist

  @sector
  Scenario: by-sector files
    When I successfully run `noodile --split-by sector sample.csv`
    Then a file named "outputs/by.sector.individual.csv" should exist
    # this traps a weird bug I somehow implemented
    And a file named "outputs/by.sector.6.41.csv" should not exist
