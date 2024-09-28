// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//VaultFactory kontratındaki fonksiyonların amacı, kullanıcıların kendi Vault’larını (kasa) oluşturmasına ve yönetmesine olanak tanımaktır. Genel olarak Factory (fabrika) deseni, bir kontratın başka kontratlar oluşturmasına izin verir. Bu örnekte, VaultFactory yeni Vault kontratlarını oluşturur ve yönetir.

contract VaultFactory {

    // Kullanıcı adreslerine karşılık gelen Vault dizilerini tutan bir mapping.
    mapping (address => Vault[]) public userVaults;

    // Sadece Vault oluşturur ve bu Vault'u kullanıcıya atar.
    function createVault() external {
        // Kullanıcı adresiyle ilişkilendirilecek yeni bir Vault oluşturuyoruz.
        Vault vault = new Vault(msg.sender);
        
        // Oluşturulan Vault'u kullanıcıya ait dizinin içine ekliyoruz.
        userVaults[msg.sender].push(vault);
    }

    // Ödeme yapılarak Vault oluşturulmasını sağlar.
    function createVaultWithPayment() external payable {
        // Ödeme içeren bir Vault oluşturuyoruz. 
        // msg.value ile belirtilen ether miktarı, oluşturulan Vault'a transfer edilir.
        Vault vault = (new Vault){value: msg.value}(msg.sender);
        
        // Oluşturulan Vault'u yine aynı şekilde kullanıcıya ait dizinin içine ekliyoruz.
        userVaults[msg.sender].push(vault);
    }
}
contract Vault {

    address public owner;
    uint256 private  balance;

    constructor (address _owner) payable{
        owner = _owner;
    }

    fallback() external payable {
        balance += msg.value;
     }

     receive() external payable { 
        balance += msg.value;
     }

    function getBalance() external view returns (uint256){
        return balance;
    }

    function deposit() external payable {
        balance += msg.value;

    }

    function Withdraw(uint256 _amount) external {
        require(msg.sender == owner,"you are not authorized.");
        balance -= _amount;
        payable(owner).transfer(_amount);
    }
}