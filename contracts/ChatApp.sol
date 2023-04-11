//SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 < 0.9.0;

contract ChatApp {
    // user structure
    struct User {
        string name;
        friend[] friendList;

    }

    struct friend {
        address pubkey;
        string name;
    }

    struct message {
        address sender;
        uint256 timestamp;
        string msg;

    }

    struct AllUsersStruct{
         string name;
         address accountAddress;
    }

    AllUsersStruct[] getAllUsers;
    mapping(address => User) userList;
    mapping(bytes32 => message[]) allMessage;


    // chech user exist

    function checkUserexist(address pubkey) public view returns(bool){
        return bytes(userList[pubkey].name).length > 0;
    } 

    // create account


    function createAccount(string calldata name) external {
        require(checkUserexist(msg.sender) == false, "User already exists");
        require(bytes(name).length > 0,"Username can not be empty");

        userList[msg.sender].name = name;
        getAllUsers.push(AllUsersStruct(name,msg.sender));

    }


    // get username

    function getusername(address pubkey) external view returns(string memory){
        require(checkUserexist(pubkey),"User not registered");
        return userList[pubkey].name;
    }



    // add frind
    function addFriend(address friend_key,string calldata name) external{
        require(checkUserexist(msg.sender),"create account first");
        require(checkUserexist(friend_key),"User not registered");
        require(msg.sender != friend_key,"user can not add himself as friend");
        require(checkAlreadyfriendornoat(msg.sender,friend_key) == false,"These user are already friends");

        _addFriend(msg.sender,friend_key,name);
        _addFriend(friend_key,msg.sender,userList[msg.sender].name);
    }


    function checkAlreadyfriendornoat(address pubkey1,address pubkey2) internal returns(bool){
        if(userList[pubkey1].friendList.length > userList[pubkey2].friendList.length){
            address tmp = pubkey1;
            pubkey1 = pubkey2;
            pubkey2 = tmp;
        }

        for(uint256 i = 0; i < userList[pubkey1].friendList.length; i++){
            if(userList[pubkey1].friendList[i].pubkey == pubkey2 ) return true; 
        }
        return false;
    }

    function _addFriend(address me , address friend_key,string memory name) internal {
        friend memory newFriend = friend(friend_key, name);
        userList[me].friendList.push(newFriend);
    }

    function getmyFriendList() external view returns(friend[] memory){
        return userList[msg.sender].friendList;
    }


    function _getchatcode(address pubkey1, address pubkey2) internal pure returns(bytes32){
        if(pubkey1 < pubkey2){
            return keccak256(abi.encodePacked(pubkey1,pubkey2));
        }else{
            return keccak256(abi.encodePacked(pubkey2,pubkey1));
        }
    }


    // send message function

    function sendMessage(address friend_key,string calldata _msg) external {
        require(checkUserexist(msg.sender),"User not registered");
        require(checkUserexist(friend_key),"User not registered");
        require(checkAlreadyfriendornoat(msg.sender,friend_key) == false,"These user are already friends");

        bytes32 chatcode = _getchatcode(msg.sender,friend_key);
        message memory newMsg = message(msg.sender,block.timestamp,_msg);
        allMessage[chatcode].push(newMsg);

    }



    // read message

    function readmessage(address friend_key) external view returns (message[] memory){
        bytes32 chatcode = _getchatcode(msg.sender,friend_key);
        return allMessage[chatcode];
    }


    function getAllAppUsers()public view returns(AllUsersStruct[] memory){
        return getAllUsers;
    }
}