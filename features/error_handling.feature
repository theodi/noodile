@error-handling
Feature: fail gracefully

  As a consumer of CSVs
  I would like noodile to fail gracefully

  Scenario: don't explode on when there's no input file
    When I run `noodile`
    Then the output should not contain "no implicit conversion of nil into String (TypeError)"