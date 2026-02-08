// SPDX-License-Identifier: MIT

pragma solidity ^0.8.21;

struct Voting {
    string urlImageCompetitor1;
    string option1;
    uint votes1;
    string urlImageCompetitor2;
    string option2;
    uint votes2;
    uint maxDate;
}

struct Vote {
    // 1 or 2
    uint choice;
    uint date;
}

struct Competitor {
    string name;
    string urlImage;
    bool eliminated;
}

contract Webbb3 {
    address owner;
    uint public currentVoting = 0;
    Voting[] public votings;
    // votes[uint][address]
    mapping(uint => mapping(address => Vote)) public votes;
    Competitor[] public competitors;

    constructor() {
        owner = msg.sender;
        addCompetitor("Peter Parker", "/src/img/peter-parker.jpg");
        addCompetitor("Mary Jane", "/src/img/mary-jane.jpg");
    }

    function addCompetitor(
        string memory name,
        string memory urlImage
    ) public {
        Competitor memory newCompetitor;
        newCompetitor.name = name;
        newCompetitor.urlImage = urlImage;
        newCompetitor.eliminated = false;
        competitors.push(newCompetitor);
    }

    function getCurrentVoting() public view returns (Voting memory) {
        return votings[currentVoting];
    }

    function addVoting(
        string memory option1,
        string memory option2,
        uint timeToVote
    ) public {
        require(msg.sender == owner, "Invalid Sender");

        if (votings.length != 0) currentVoting++;

        Voting memory newVoting;
        newVoting.option1 = option1;
        newVoting.option2 = option2;
        newVoting.urlImageCompetitor1 = competitors[0].urlImage;
        newVoting.urlImageCompetitor2 = competitors[1].urlImage;
        newVoting.maxDate = timeToVote + block.timestamp;
        votings.push(newVoting);
    }

    function addVote(uint choice) public {
        require(choice == 1 || choice == 2, "Invalid Choice");
        require(getCurrentVoting().maxDate > block.timestamp, "No Open Voting");
        require(
            votes[currentVoting][msg.sender].date == 0,
            "You already voted on this voting"
        );

        votes[currentVoting][msg.sender].choice = choice;
        votes[currentVoting][msg.sender].date = block.timestamp;

        if (choice == 1) votings[currentVoting].votes1++;
        else votings[currentVoting].votes2++;
    }

    function getVotingWinner(uint votingId) public returns (string memory) {
        require(votings[votingId].votes1 != votings[votingId].votes2, "No Winner");

        if (votings[votingId].votes1 > votings[votingId].votes2) {
            competitors[0].eliminated = true;
            return competitors[0].name;
        } else {
            competitors[1].eliminated = false;
            return competitors[1].name;
        }
    }
}