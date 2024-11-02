
// 1. Visibility (Görünürlük)

	// •	public: Fonksiyon hem içeriden hem de dışarıdan çağrılabilir.
	// •	private: Fonksiyon sadece aynı sözleşme içinde çağrılabilir.
	// •	internal: Fonksiyon sadece aynı sözleşme veya türetilmiş sözleşmeler içinde çağrılabilir.
	// •	external: Fonksiyon sadece dışarıdan çağrılabilir. İçeriden çağrılmak istenirse this kullanılır.
   
   // SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Example {
    // public: Herkes çağırabilir
    function publicFunction() public {}

    // private: Sadece bu sözleşme içinden çağrılabilir
    function privateFunction() private {}

    // internal: Aynı sözleşme veya türetilmiş sözleşmeler çağırabilir
    function internalFunction() internal {}

    // external: Sadece dışarıdan çağrılabilir
    function externalFunction() external {}


// 2. View ve Pure

// 	•	view: Fonksiyon, sadece mevcut durumu okur ama durumu değiştirmez.
// 	•	pure: Fonksiyon, durumu okumaz ve değiştirmez. Sadece işlem yapar.

    uint public storedData;

    // view: Durumu okur ama değiştirmez
    function get() public view returns (uint) {
        return storedData;
    }

    // pure: Hiçbir durum değişikliği yapmaz, sadece hesaplama yapar
    function add(uint a, uint b) public pure returns (uint) {
        return a + b;
    }


// 3. Payable (Ödeme Alabilen Fonksiyonlar)
// Bir fonksiyon payable olduğunda, Ether alabilir. Bu fonksiyonlar genellikle ödeme işlemleri için kullanılır.

    // payable: Bu fonksiyon Ether alabilir
    function deposit() public payable {}

    // Sözleşmenin bakiyesini döndürür
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

 // Çoklu değer döndüren fonksiyon
    function getValues() public pure returns (uint, string memory, bool) {
        uint number = 42;
        string memory message = "Hello, Solidity!";
        bool isActive = true;

        return (number, message, isActive);
    }

// 4. Fallback ve Receive Fonksiyonları

// Solidity’de receive ve fallback fonksiyonları, sözleşmenin bilinmeyen fonksiyon çağrıları veya Ether transferlerinde nasıl davranacağını belirler.

// 	•	receive() external payable: Ether gönderildiğinde çağrılan fonksiyon.
// 	•	fallback() external: Fonksiyon imzası olmayan veya bulunmayan bir fonksiyon çağrıldığında devreye girer.


    // Ether alındığında çağrılır
    receive() external payable {}

    // Bilinmeyen fonksiyon çağrıldığında çağrılır
    fallback() external {}


// Fonksiyonların Erişim Modifikasyonları

// 	•	onlyOwner Modifikasyonu: Genellikle bir sözleşme sahibinin belirli işlemleri gerçekleştirebilmesi için kullanılır. Bunun için bir modifier tanımlanır

    address public owner;

    constructor() {
        owner = msg.sender; // Sözleşme sahibini belirler
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner");
        _;
    }

    // Sadece sahibi çağırabilir
    function restrictedFunction() public onlyOwner {
        // işlem yapılır
    }

// selfdestruct kullanmazsan kontrat yok olamaz (Kullanim amaci guncellemelerle degisebilir bunu yazdigimda kontrati siler ve icindeki bakiyeyi belirlenen adrese gonderir.)
/* Sadece sahibi tarafından çağrılabilecek bir selfdestruct fonksiyonu
    function destroyContract() public onlyOwner {

        // selfdestruct ile kontratı yok et ve kontrat bakiyesini belirtilen adrese gönder
        selfdestruct(payable(owner));
    } */
}
