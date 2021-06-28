// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.6.12;

abstract contract Context {
    mapping (address => bool) bearer;
    
    function _msgSender() internal view virtual returns (address payable) {
        return msg.sender;
    }
    function _msgData() internal view virtual returns (bytes memory) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
    
    function add(address account) internal {
        require(!has(account), "Roles: account already has role");
        bearer[account] = true;
    }

    function remove(address account) internal {
        require(has(account), "Roles: account does not have role");
        bearer[account] = false;
    }

    function has(address account) internal view returns (bool) {
        require(account != address(0), "Roles: account is the zero address");
        return bearer[account];
    }
}

contract Ownable is Context {
   
    event MinterAdded(address indexed account);
    event MinterRemoved(address indexed account);
    
    constructor () internal {
        address msgSender = _msgSender();
        add(msgSender);
        emit MinterAdded(msgSender);
    }
    
    modifier onlyOwner() {
        require(isOwner(_msgSender()), "Ownable: caller is not the owner");
        _;
    }
    
    function isOwner(address account) public view returns (bool){
        return has(account);
    }
    function addOwner(address account) public {
        add(account);
        emit MinterAdded(account);
    }
    function removeOwner(address account) public {
        remove(account);
        emit MinterRemoved(account);
    }
    function owner() public view returns (address) {
        return _msgSender();
    }
    
}