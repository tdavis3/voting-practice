pragma solidity ^0.7.6;

contract Election {

  uint startTime;  /// Time the election started
  uint endingTime;  /// Time the election ends
  uint votingPeriod;  /// Length of voting period
  uint registrationPeriod;  /// Length of registration period

  /// Array of candidates in this election
  string[] public candidates;

  /// Mapping from candidateId to votes for that candidate (values initialized to -1)
  mapping(uint => int) votes;

  /// Mapping from voter address to 1
  mapping(uint => int) voters;

  /// @notice Create an election
  /// @param registrationPeriod
  /// @param votingPeriod
  /// @param endingTime
  /// @return address of the newly started election contract
  constructor(uint _registrationPeriod, uint _votingPeriod, uint _endingTime) {
    
  }

  /// @notice Candidate registration only during registration period
  function registerCandidate() external view {

  }

  /// @notice Cast a vote only during voting period
  /// @param candidateId The position of a candidate in candidates
  function vote(uint candidateId) public {

  }

}
