@progress
Feature: show some progress dots

  As a consumer of CSVs
  I want to see that noodile is doing something

  Background: set up the sample data
    Given a file named "sample.csv" with:
    """
    "","foo","bar","baz"
    "1","30265","9843","4406"
    "2","17280","27666","32678"
    "3","24855","17099","5758"
    "4","3709","2554","23417"
    "5","25240","9711","23546"
    "6","3105","663","18606"
    "7","19326","3498","730"
    "8","18249","19234","1229"
    "9","9143","9216","22630"
    "10","20303","1028","22635"
    "11","10009","26876","26721"
    "12","22729","6019","9314"
    "13","11084","28969","25429"
    "14","13139","8674","22587"
    "15","11602","15128","374"
    "16","5107","24505","28789"
    "17","4563","3043","1401"
    "18","30561","14417","25941"
    "19","2580","642","10138"
    "20","1323","3151","28266"
    "21","16442","21368","12191"
    "22","21652","28136","7386"
    "23","6226","21020","3478"
    "24","11677","32384","32322"
    "25","10298","657","945"
    "26","19613","3674","11175"
    "27","14155","22303","8282"
    "28","15438","30146","19404"
    "29","20357","26000","3710"
    "30","31289","9181","5611"
    "31","23691","15559","21155"
    "32","15088","15875","14749"
    "33","12709","157","5691"
    "34","14183","4938","10875"
    "35","18096","464","22366"
    "36","25208","19120","6592"
    "37","15518","6530","25032"
    "38","11605","16131","21991"
    "39","29937","5027","3791"
    "40","2927","8825","18476"
    """

  Scenario: process the file and see some progress indicators
    When I successfully run `noodile --progress sample.csv`
    Then the output should contain "."