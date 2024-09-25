// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ilk once interact i deploy ediyoruz
// sonra callera interact contractinin adresini girerek deploy ediyoruz

// Interact adında bir sözleşme oluşturuyoruz
// Bu sözleşme çağrılan kişinin adresini saklıyor ve çağrıları kaydediyor
contract Interact {
    // Son çağrıyı yapan kişinin adresi
    address public caller;
    // Her adres için çağrı sayısını tutan bir mapping
    mapping (address => uint256) public counts;

    // Bu fonksiyon çağrıldığında, fonksiyonu çağıran kişinin adresi kaydedilir
    // Ve bu adresin çağrı sayısı 1 artırılır
    function callThis() external {
        caller = msg.sender;
        counts[msg.sender]++;
    }
}

// Pay adında bir sözleşme oluşturuyoruz
// Bu sözleşme Ether ödemelerini kabul ediyor ve her kullanıcının bakiyesini kaydediyor
contract Pay {
    // Her kullanıcı için bakiyeleri saklayan bir mapping
    mapping (address => uint256) public userBalance;

    // Ether ödemesini kabul eden fonksiyon
    // Gönderilen Ether'i belirtilen adresin bakiyesine ekler
    function payEth(address _payer) external payable {
        userBalance[_payer] += msg.value;
    }
}

// Caller adında bir sözleşme oluşturuyoruz
// Bu sözleşme, Interact sözleşmesi ile etkileşime geçiyor
contract Caller {
    // Interact sözleşmesini tanımlıyoruz
    Interact interact;

    // Constructor: Sözleşme oluşturulurken Interact sözleşmesinin adresini alır ve kaydeder
    constructor(address _interactContract) {
        interact = Interact(_interactContract);
    }

    // Interact sözleşmesindeki callThis fonksiyonunu çağıran fonksiyon
    function callInteract() external {
        interact.callThis();
    }

    // Interact sözleşmesindeki son çağıranın adresini okuyan fonksiyon
    function readCaller() external view returns (address) {
        return interact.caller();
    }

    // Interact sözleşmesinde bir adresin kaç kez çağrı yaptığını okuyan fonksiyon
    function readCallerCount() public view returns (uint256) {
        return interact.counts(msg.sender);
    }

    // Başka bir Pay sözleşmesine Ether gönderen fonksiyon
    // Gönderilen Ether belirtilen adresin bakiyesine eklenir
    function payToPay(address _payAddress) public payable {
        Pay pay = Pay(_payAddress); // Pay sözleşmesini tanımlıyoruz
        pay.payEth{value: msg.value}(msg.sender); // msg.sender adresine Ether ödemesini ekliyoruz
    }

    // Interact sözleşmesine Ether gönderen fonksiyon
    // Transfer fonksiyonu ile gönderilen miktarı Interact sözleşmesine gönderir
    function sendEthByTransfer() public payable {
        payable(address(interact)).transfer(msg.value);
    }
}

// 1.	Interact Sözleşmesi:
// 	•	Bu sözleşme, fonksiyonu çağıran kişinin adresini (msg.sender) kaydediyor ve bu adrese ait bir sayaç tutuyor.
// 	•	caller: Son çağrıyı yapan kişinin adresi.
// 	•	counts: Her bir adresin kaç kere bu fonksiyonu çağırdığını tutan bir sayaç.

// 	2.	Pay Sözleşmesi:
// 	•	Bu sözleşme, gönderilen Ether’i kabul ediyor ve her bir kullanıcının bakiyesini saklıyor.
// 	•	payEth: Ödeme yapıldığında, gönderen kişinin bakiyesine gelen Ether’i ekleyen fonksiyon.

// 	3.	Caller Sözleşmesi:
// 	•	Caller sözleşmesi, deploy edilirken Interact sözleşmesinin adresini alıyor ve onu kaydediyor.
// 	•	callInteract: Interact sözleşmesindeki callThis fonksiyonunu çağırıyor.
// 	•	readCaller: Interact sözleşmesindeki son çağıranı döndürüyor.
// 	•	readCallerCount: msg.sender adresinin Interact sözleşmesinde kaç kere çağrı yaptığını döndürüyor.
// 	•	payToPay: Başka bir Pay sözleşmesine Ether gönderiyor ve msg.sender’ın bakiyesine ekliyor.
// 	•	sendEthByTransfer: Interact sözleşmesine direkt Ether gönderiyor.