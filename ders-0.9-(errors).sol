//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Example {
    uint public balance;
    address public owner;

    constructor() {
        owner = msg.sender; // Kontratı oluşturan adresi sahibi olarak ayarla
    }

    // Kullanıcıların para yatırmasını sağlar
    function deposit() public payable {
        balance += msg.value; // Gönderilen değeri bakiyeye ekle
    }

    // Para çekme işlemi
    function withdraw(uint amount) public {
        // 1. require: Koşul sağlanmazsa hata mesajı ile işlemi geri alır
        require(msg.sender == owner, "Only owner can call this function.");
        
        // 2. assert: Bu koşul her zaman doğru olmalıdır, yanlışsa işlemi geri alır ve tüm gazı yakar
        assert(balance >= amount); 

        // 3. revert: Koşul sağlanmazsa, isteğe bağlı bir mesajla işlemi geri alır
        if (amount > balance) {
            revert("Insufficient balance.");
        }

        balance -= amount; // Bakiyeden çekilen miktarı çıkar
        payable(msg.sender).transfer(amount); // Kullanıcıya parayı gönder
    }

    // 4. Özel hata tanımı: Hata durumunu daha okunabilir hale getirir
    error InsufficientBalance(uint requested, uint available);

    // Para çekme işlemi (özel hata kullanarak)
    function withdrawWithCustomError(uint amount) public {
        if (amount > balance) {
            // Özel hata kullanımı: İlgili bilgilerle hatayı geri döner
            revert InsufficientBalance(amount, balance);
        }

        balance -= amount; // Bakiyeden çekilen miktarı çıkar
        payable(msg.sender).transfer(amount); // Kullanıcıya parayı gönder
    }
}
