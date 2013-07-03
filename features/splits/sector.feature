@sectors
Feature: split CSV by sector

  As a consumer of CSVs
  I want to split CSVs by sector

  Background: set up the sample data
    Given a file named "sample.csv" with:
    """
    "","outcode.len","region.len","outcode.bor","region.bor","loan.id","postcode.bor","originated","maturity","term","loan.part.value","loan.rate","sector","postcode.len","platform","area.len","area.bor","incode.len","incode.bor"
    "1","AAA","Scotland","BBB","North West","0000B535-182A-11E0-9801-0050569D002A","BBBCCC",2011-01-05 16:34:53,2016-02-01,60,10,8.04,"Individual","AAADDD","Zopa","AAA","BBB","DDD","CCC"
    "4","AAA","East of England","BBB","North West","0000B535-182A-11E0-9801-0050569D002A","BBBCCC",2011-01-05 16:34:53,2016-02-01,60,10,8.04,"Individual","AAADDD","Zopa","AAA","BBB","DDD","CCC"
    "160","AAA","London","BBB","North West","0000B535-182A-11E0-9801-0050569D002A","BBBCCC",2011-01-05 16:34:53,2016-02-01,60,10,8.04,"Individual","AAADDD","Zopa","AAA","BBB","DDD","CCC"
    "410","AAA","South West","BBB","Wales","0001533F-716C-E111-90C3-0050569D002D","BBBCCC",2012-03-13 16:47:15,2015-04-03,36,10,6.41,"Individual","AAADDD","Zopa","AAA","BBB","DDD","CCC"
    "656","AAA","Scotland","BBB","East Midlands","0004CBFB-9D05-11E0-B2F6-005056B70006","BBBCCC",2011-06-27 16:10:04,2014-07-10,36,10,6.46,"Individual","AAADDD","Zopa","AAA","BBB","DDD","CCC"
    "943","AAA","East of England","BBB","South East","00062E55-2CA5-11E0-9A31-0050569D002C","BBBCCC",2011-02-01 16:09:40,2016-02-01,60,10,8.21,"Individual","AAADDD","Zopa","AAA","BBB","DDD","CCC"
    """

  Scenario: split by sector
    When I successfully run `noodile --split-by sector sample.csv`
    Then a 960 byte file named "outputs/by.sector.individual.csv" should exist
    And the file "outputs/by.sector.individual.csv" should contain:
    """
    "",outcode.len,region.len,outcode.bor,region.bor,loan.id,originated,maturity,term,loan.part.value,loan.rate,sector,platform,area.len,area.bor
    1,AAA,Scotland,BBB,North West,0000B535-182A-11E0-9801-0050569D002A,2011-01-05 16:34:53,2016-02-01,60,10,8.04,Individual,Zopa,AAA,BBB
    4,AAA,East of England,BBB,North West,0000B535-182A-11E0-9801-0050569D002A,2011-01-05 16:34:53,2016-02-01,60,10,8.04,Individual,Zopa,AAA,BBB
    160,AAA,London,BBB,North West,0000B535-182A-11E0-9801-0050569D002A,2011-01-05 16:34:53,2016-02-01,60,10,8.04,Individual,Zopa,AAA,BBB
    410,AAA,South West,BBB,Wales,0001533F-716C-E111-90C3-0050569D002D,2012-03-13 16:47:15,2015-04-03,36,10,6.41,Individual,Zopa,AAA,BBB
    656,AAA,Scotland,BBB,East Midlands,0004CBFB-9D05-11E0-B2F6-005056B70006,2011-06-27 16:10:04,2014-07-10,36,10,6.46,Individual,Zopa,AAA,BBB
    943,AAA,East of England,BBB,South East,00062E55-2CA5-11E0-9A31-0050569D002C,2011-02-01 16:09:40,2016-02-01,60,10,8.21,Individual,Zopa,AAA,BBB
    """