var Revoke = artifacts.require('./Revoke.sol')

contract('Revoke:mainTests', function(accounts) {
  it("Initial batch revocation status is false", function(done) {
    var revoke = Revoke.deployed();

    revoke.then(function(contract){
      return contract.getBatchRevocationStatus.call();
    }).then(function(result){
      assert.isFalse(result);
      done();
    })
  });
  it("Non-issuer can't revoke", function(done) {
    var revoke = Revoke.deployed();

    revoke.then(function(contract){
      return contract.revokeBatch({from: accounts[1]}); //account1 is not the issuer
    }).catch(function(error){
      if(error){
        assert.isTrue(true);
        done();
      }
    })
  });
  it("Issuer can revoke", function(done) {
    var revoke = Revoke.deployed();

    revoke.then(function(contract){
      return contract.revokeBatch({from: accounts[0]}); //account1 is not the issuer
    }).then(function (result) {
      assert.isTrue(result.tx.length > 60);
      done()
    })
  });
});

