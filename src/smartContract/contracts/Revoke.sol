pragma solidity ^0.4.15;
// We have to specify what version of compiler this code will compile with

// Revoke.deployed().then(function(contractInstance) {contractInstance.getRevocationStatusOfParty.call('issuer').then(function(v) {console.log(v)})})
// Revoke.deployed().then(function(contractInstance) {contractInstance.revokeForParty('issuer').then(function(v) {console.log(v)})})

// Revoke.deployed().then(function(contractInstance) {contractInstance.checkAddress.call().then(function(v) {console.log(v)})})


contract Revoke {

	// private only means it can not be modified by external contracts,
	// anyone can read


	bool public issuerRevokedBatch = false;
	//bool public receiverRevoked = false;

	bytes32 public ipfsLinkSha3Digest;

	string public bitcoinTxid;
	string public batchMerkleRoot;

	address public issuerAddress;
	address public receiverAddress;


	/* This is the constructor which will be called once when you
    deploy the contract to the blockchain. When we deploy the contract,
    we will pass an array with the addresses of the issuer and the receiver
    */
	function Revoke(bytes32 ipfsLinkHash) public {
		issuerAddress = msg.sender;
		ipfsLinkSha3Digest = ipfsLinkHash;

	}


	// I'd like to return the issuerRevokedBatch and receiverRevoked
	// separately but can0t seem to return a bool []  :(
	function getBatchRevocationStatus() constant public returns (bool){
		// Assuming only the issuer can revoke
		return issuerRevokedBatch;
	}

	function setBatcMerkleRoot(string merkleRoot) public{
		require(checkAddress());
		batchMerkleRoot = merkleRoot;

	}

	function setBitcoinTxid(string btcTxid) public {
		require (checkAddress());
		bitcoinTxid = btcTxid;
	}


	function revokeBatch() public{
		require(checkAddress());
			issuerRevokedBatch = true;
	}

	function checkAddress() constant  public returns (bool){
		if(msg.sender == issuerAddress){
			return true;
		}
		return false;
	}

}