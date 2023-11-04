//SPDX-License-Identifier:MIT

pragma solidity ^0.8.10;

import '@openzeppelin/contracts/access/Ownable.sol';

contract Election is Ownable{
    struct candidate{
        string name;
        uint index;
        uint votecount;
    }
    struct voter{
        string name;
        uint index;
        bool voted;
    }
    mapping (uint => candidate) public candidates;
    mapping (uint => voter) public voters;

    constructor() {
        candidates[1] = candidate("Rahul",1,0);
        candidates[2] = candidate("Priya",2,0);
    }
    function vote(string memory votersName,uint cIndex) public {
        require(voters[cIndex].voted,"already voted");
        voters[cIndex] = voter(votersName,cIndex,true);
        candidates[cIndex].votecount++;
    }
    function getwinner() public view onlyOwner returns(uint,string memory){
        uint maxVotes = 0;
        uint winnerIndex = 0;

        for (uint i = 1; i <= 2; i++) {
            if (candidates[i].votecount > maxVotes) {
                maxVotes = candidates[i].votecount;
                winnerIndex = i;
            }
        }
        
        return (candidates[winnerIndex].index, candidates[winnerIndex].name);
    }
}
