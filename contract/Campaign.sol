pragma solidity ^0.4.19;

contract Campaign {
    struct Request {
        string description;
        uint value;
        address recipient;
        bool complete;
    }
    
    Request[] public requests;
    address public manager;
    uint public minimumContribution;
    address[] public approvers;

    modifier restricted {
        require(msg.sender == manager);
        _;
    }
    
    function createRequest(string description, uint value, address recipient) public restricted {
        Request newRequest = Request({
            description: description,
            value: value,
            recipient: recipient,
            complete: false
        });
        
        requests.push(newRequest);
    }
    
    function Campaign(uint minimum) public {
        manager = msg.sender;
        minimumContribution = minimum;
    }
    
    function contribute() public payable {
        require(msg.value > minimumContribution);
        approvers.push(msg.sender);
    }
}