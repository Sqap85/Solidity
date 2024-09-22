//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


    // Send Ethers Functions 

    // Transfer kullanarak Ether gönderme
    // Transfer fonksiyonu güvenlidir ve başarısız olursa işlem iptal edilir (revert).
    // Gönderilen gas miktarı sabittir: 2300 gas.
    // Basit ve güvenli bir yöntemdir, ancak gas sınırlaması nedeniyle yalnızca basit işlemler yapılabilir

    // Send kullanarak Ether gönderme
    // Send fonksiyonu da transfer gibi Ether gönderir, ancak başarısız olduğunda false döner ve hata fırlatmaz.
    // Gönderilen gas miktarı yine sabittir: 2300 gas.
    // Eğer işlem başarısız olursa, manuel olarak kontrol edip ona göre işlem yapmalıyız.

    // Call kullanarak Ether gönderme
    // Call, düşük seviyeli bir fonksiyondur ve en esnek yöntemdir.
    // Gönderilen gas miktarını manuel olarak ayarlayabiliriz ve gönderimle birlikte başka işlemler de yapılabilir.
    // Call fonksiyonu da send gibi başarısız olduğunda false döner, hata fırlatmaz. İşlemin sonucunu kontrol etmek zorundayız.
    
    //•	receive: Eğer bir kontrat direkt olarak Ether alacaksa ve gönderilen işlemde çağrılan bir fonksiyon yoksa, Ether’i almak için kullanılır. Bu fonksiyon yalnızca msg.data boş olduğunda çağrılır.
	//•	receive() fonksiyonu mutlaka external payable olarak tanımlanmalıdır.

    //•	fallback: Bir kontrata Ether gönderilirken belirli bir fonksiyon çağrılmazsa ve msg.data varsa bu fonksiyon tetiklenir. fallback fonksiyonu sadece Ether almak için değil, aynı zamanda bilinmeyen fonksiyon çağrıları veya hatalı fonksiyon çağrılarında da devreye girebilir.
	//•	fallback() fonksiyonu, payable yapılabilir, böylece kontrata Ether gönderilebilir.

contract Bank {

    mapping(address => uint) balances;

    function sendEtherToContract() payable external {
        balances[msg.sender] = msg.value;
    }

    function ShowBalances () external view  returns (uint) {
        return balances[msg.sender];
    }

    function withdraw(address payable to,uint amount) external {
        // require(balances[msg.sender] >= amount,"insufficient funds");
        to.transfer(amount);
        balances[to] += amount;//balances[to] ifadesi, to adresinin bakiyesini temsil eder.
        balances[msg.sender] -= amount;
    }

    uint public  ReceiveCount =0;
    uint public  FallBackCount =0;
     
    receive() external payable {
        ReceiveCount++;
    }

    fallback() external payable {
        FallBackCount++;
    }

}