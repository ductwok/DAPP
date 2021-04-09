
pragma solidity >=0.4.22 <0.6.0;

contract Ballot {
     
    struct Voter {
        uint weight;// co quyen vote hay ko 
        bool voted; //da vote hay chua
        address delegate; // chuyen cho ai 
        uint vote;// vote cho quan
    }
    
    struct Proposal {
        bytes32 name;// ten thang duoc vote
        uint voteCount;// dem so vote
    }
    
    address public chairperson;//thang dung dau to chuc ao den
    
    
    mapping (address => Voter) public voters;
    
    Proposal [] public proposals;
    
    constructor (bytes32 [] memory proposalNames) public { // yeu cau 1 mang nhieu cu tri 
        chairperson = msg.sender;
        voters [chairperson].weight = 1;
        
        
        for (uint i = 0; i < proposalNames.length; i++) {
            
            
            
            proposals.push(Proposal ( {
                name: proposalNames[i],
                voteCount: 0
            }));
        }
    }
    
    
    function giverRightToVote(address voter) public { // cap quyen 
        
        
        
        
        
        
        require (  msg.sender == chairperson,"Only chairperson can give right to vote."); // neu ko phai chu thi out 
            require(!voters[voter].voted, "The voter already voted.");// neu da vote ma duoc cap lai quyen se loi nay
            require(voters[voter].weight == 0); 
            voters[voter].weight = 1;
        
    }
    
    function delegate(address to) public {// chuyen quyen cho ng khac
        
        Voter storage sender = voters[msg.sender];
        require(!sender.voted, "You already voted.");// neu da vote roi ma cap quyen cho ng khac se bao loi 
        
        require(to != msg.sender, "Self-delegation is disallowed.");// ng chuyen ko ton tai se bao loi 
        
        
        
        while (voters[to].delegate != address(0)) {
            to = voters[to].delegate;
            
            
            require(to != msg.sender, "Found loop in delegation.");// nhu tren
        
        }
        
        
        sender.voted = true;
        sender.delegate = to;
        Voter storage delegate_ = voters[to];
        if (delegate_.voted) {
            
            
            proposals[delegate_.vote].voteCount += sender.weight;
            
        }else {
            
            delegate_.weight += sender.weight;
        }
    }
    
    function vote (uint proposal) public {// vote
        Voter storage sender = voters[msg.sender];//
        require(sender.weight != 0, "Has no right to vote");// khong co quyen se ko duoc vote
        require(!sender.voted, "Already voted.");// vote roi ko co lan 2
        sender.voted = true;// 
        sender.vote = proposal;
        
        
        
        proposals[proposal].voteCount += sender.weight;
    }
    
    
    function winningProposal() public view // tinh ti le nguoi chien thang cao nhat
    returns (uint winningProposal_)
    {
        uint winningVoteCount = 0;
        for (uint p = 0; p < proposals.length; p++) {
            if (proposals[p].voteCount > winningVoteCount) {
                winningVoteCount = proposals[p].voteCount;
                winningProposal_ = p;
            }
        }
    }
    
    function winnerName() public view // thang win
    returns (bytes32 winnerName_)
    {
        winnerName_ = proposals[winningProposal()].name;
    }
}