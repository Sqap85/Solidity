// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Token85 is ERC20, Ownable {
    // Token'un toplam arzı
    uint256 private _totalSupply;

    // Sözleşmeyi başlatma ve toplam arz belirleme
    constructor(uint256 initialSupply) 
        ERC20("Token85", "85") 
        Ownable(msg.sender)
    {
        _totalSupply = initialSupply * (10 ** decimals());
        _mint(msg.sender, _totalSupply); // Başlangıç arzını sahibinin adresine aktar
    }

    // Toplam arzı döndür
    function totalSupply() public view override returns (uint256) {
        return _totalSupply;
    }

    // Token transferini kontrol eden fonksiyon (ERC20 standart fonksiyonu)
    function transfer(address recipient, uint256 amount) public override returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    // Belirli bir adrese token gönderme
    function mint(address account, uint256 amount) public onlyOwner {
        _mint(account, amount);
    }

    // Token'ı belirli bir adrese yakma
    function burn(uint256 amount) public {
        _burn(_msgSender(), amount);
    }
}