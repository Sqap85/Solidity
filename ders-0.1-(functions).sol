// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Example {
    // 1. Visibility (Görünürlük)

    // public: Herkes çağırabilir
    function publicFunction() public {}

    // private: Sadece bu sözleşme içinden çağrılabilir
    function privateFunction() private {}

    // internal: Aynı sözleşme veya türetilmiş sözleşmeler çağırabilir
    function internalFunction() internal {}

    // external: Sadece dışarıdan çağrılabilir
    function externalFunction() external {}

    // 2. View ve Pure Fonksiyonları

    uint public storedData; // Durumu tutan bir değişken

    // view: Durumu okur ama değiştirmez
    function get() public view returns (uint) {
        return storedData; // storedData'nın mevcut değerini döndürür
    }

    // pure: Hiçbir durum değişikliği yapmaz, sadece hesaplama yapar
    function add(uint a, uint b) public pure returns (uint) {
        return a + b; // İki sayıyı toplar ve sonucu döndürür
    }

    // 3. Payable (Ödeme Alabilen Fonksiyonlar)
    // Bir fonksiyon payable olduğunda, Ether alabilir.

    // payable: Bu fonksiyon Ether alabilir
    function deposit() public payable {} // Kullanıcı Ether gönderdiğinde çağrılabilir

    // Sözleşmenin bakiyesini döndürür
    function getBalance() public view returns (uint) {
        return address(this).balance; // Sözleşmenin mevcut Ether bakiyesini döndürür
    }

    // Çoklu değer döndüren fonksiyon
    function getValues() public pure returns (uint, string memory, bool) {
        uint number = 42; // Bir sayı tanımlar
        string memory message = "Hello, Solidity!"; // Bir mesaj tanımlar
        bool isActive = true; // Bir boolean değeri tanımlar

        return (number, message, isActive); // Üç değeri bir arada döndürür
    }

    // 4. Fallback ve Receive Fonksiyonları

    // Ether alındığında çağrılır
    receive() external payable {} // Ether gönderildiğinde bu fonksiyon tetiklenir

    // Bilinmeyen fonksiyon çağrıldığında çağrılır
    fallback() external {} // Sözleşme içindeki tanımlı olmayan bir fonksiyon çağrıldığında bu fonksiyon tetiklenir

    // Fonksiyonların Erişim Modifikasyonları

    address public owner; // Sözleşme sahibinin adresi

    constructor() {
        owner = msg.sender; // Sözleşme oluşturulduğunda sahibini belirler
    }

    //// onlyOwner Modifikasyonu: Genellikle bir sözleşme sahibinin belirli işlemleri gerçekleştirebilmesi için kullanılır
    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner"); // Sadece sözleşme sahibi erişebilir
        _; // Modifikatörün kullanıldığı yeri belirtir
    }

    // Sadece sahibi çağırabilir
    function restrictedFunction() public onlyOwner {
        // İşlem yapılır, yalnızca sahip tarafından çağrılabilir
    }

    // selfdestruct kullanmazsan kontrat yok olamaz
    /* Sadece sahibi tarafından çağrılabilecek bir selfdestruct fonksiyonu
    function destroyContract() public onlyOwner {
        // selfdestruct ile kontratı yok et ve kontrat bakiyesini belirtilen adrese gönder
        selfdestruct(payable(owner));
    } */
    
    // 5. Function Overloading (Fonksiyon Aşırı Yükleme)
    
    // Aynı isimde farklı parametre sayıları veya türleri ile tanımlanan fonksiyonlar
    function multiply(uint a, uint b) public pure returns (uint) {
        return a * b; // İki sayıyı çarpar
    }

    function multiply(uint a, uint b, uint c) public pure returns (uint) {
        return a * b * c; // Üç sayıyı çarpar
    }
}
