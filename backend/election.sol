pragma solidity ^0.7.6;


contract ElectionFactory {

  /// @notice Create an election
  /// @param registrationPeriod
  /// @param votingPeriod
  /// @param endingTime
  /// @return address of the newly started election contract
  function createElection(uint registrationPeriod, uint votingPeriod, uint endingTime) public returns (address) {
    Election election = new Election(registrationPeriod, votingPeriod, endingTime);
    return address(election);
  }

}


/// @notice This class represents a standalone election
contract Election {

  uint startTime;  /// Time the election started
  uint endingTime;  /// Time the election ends
  uint votingPeriod;  /// Length of voting period
  uint registrationPeriod;  /// Length of registration period

  /// Array of candidates in this election
  address[] public candidates;

  /// Mapping from candidate address to votes for that candidate (values initialized to -1)
  mapping(address => int) public votes;

  /// Mapping from voter address to 1
  mapping(address => int) public voters;

  /// @notice Create an election
  /// @param registrationPeriod
  /// @param votingPeriod
  /// @param endingTime
  /// @return address of the newly started election contract
  constructor(uint _registrationPeriod, uint _votingPeriod, uint _endingTime) {
    startTime = block.timestamp;
    endingTime = _endingTime;
    votingPeriod = _votingPeriod;
    registrationPeriod = _registrationPeriod;
  }

  /// @notice Candidate registration only during registration period
  function registerCandidate() external {
    require(block.timestamp >= startTime && block.timestamp <= (startTime + registrationPeriod), 'Cannot register a candidate outside of registration period.');
    require(votes[msg.sender] == 0, 'Candidate already exists.');
    candidates.push(msg.sender);
    votes[msg.sender] = -1;
  }

  /// @notice Cast a vote only during voting period
  /// @param candidate The address of a candidate in candidates
  function vote(address candidate) external {
    require(block.timestamp >= (startTime + registrationPeriod) && block.timestamp <= endingTime, 'Cannot vote outside of voting period.');
    require(votes[candidate] == -1 || votes[candidate] > 0, 'Candidate does not exist.');
    require(voters[msg,sender] == 0, "Cannot vote more than once.");
    if (votes[candidate] == -1) {
      votes[candidate] = 1;
    } else {
      votes[candidate] += 1;
    }
    voters[msg.sender] = 1;
  }

  /// @notice Get all registered candidates
  function getCandidates() external view returns (address[] memory) {
    return candidates;
  }

  /// @notice Get vote count for a candidate
  function getVoteCount(address candidate) external view returns (uint) {
    require(votes[candidate] == -1 || votes[candidate] > 0, 'Candidate does not exist.');
    return votes[candidate] == -1 ? 0 : votes[candidate];
  }

}
