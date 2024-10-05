// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
Soru: Bir akıllı sözleşme oluşturun. Bu sözleşme bir kullanıcının bakiyesini takip etsin. Kullanıcıların bakiyelerini artırmak ve azaltmak için iki fonksiyon yazın: deposit ve withdraw. Bakiyeyi kontrol etmek için getBalance fonksiyonunu da ekleyin.
*/
contract Basic {

    mapping(address => uint256) private balances;

    // Kullanıcının bakiyesini artırmak için fonksiyon
    function deposit() external payable GreaterThanZeroControl {
        balances[msg.sender] += msg.value;
    }

    // Kullanıcının bakiyesini azaltmak için fonksiyon
    function withdraw(address payable to, uint256 amount) external GreaterThanZeroControlWithParameter(amount) {
        require(amount <= balances[msg.sender], "Invalid amount");
        to.transfer(amount);
        balances[msg.sender] -= amount;
    }

    // Kullanıcının bakiyesini döndüren fonksiyon
    function getBalance() external view returns (uint256) {
        return balances[msg.sender];
    }

    // Depozito kontrol modifier'ı
    modifier GreaterThanZeroControl {
        require(msg.value > 0, "Deposited amount must be greater than zero!");
        _;
    }

    // Parametre ile kontrol modifier'ı
    modifier GreaterThanZeroControlWithParameter(uint256 amount) {
        require(amount > 0, "Withdrawn amount must be greater than zero!");
        _;
    }
}