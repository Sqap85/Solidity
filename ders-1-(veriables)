// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Variables {
    // Sabit boyutlu veri türleri
    bool public isTrue = true;  // Varsayılan değeri true
    // bool public isTrue; // Bu satır, varsayılan olarak false değeri alır

    int public number = 85; // -2^255 ile 2^255-1 arası değerler alabilir
    int8 public num; // -128 ile 127 arası değerler alabilir
    uint public plus; // 0 ile 2^256-1 arası pozitif değerler alabilir

    // Adres veri türü 20 byte yer kaplar
    address public myAddress = 0xd151766DB2A9a77e0007e81AAE7EeA889104fFBf;

    // Bytes veri türleri
    bytes public nameByte1 = "senay"; // Dinamik uzunlukta bayt dizisi
    bytes32 public nameByte2 = "engin"; // Sabit uzunlukta 32 bayt (256 bit) veri

    // Dinamik boyutlu veri türleri
    string public name1 = "senay"; // Dinamik uzunlukta string

    // Diziler
    uint[3] public fixedArray = [1, 2, 3]; // Sabit uzunluklu dizi (3 elemanlı)
    uint[] public dynamicArray; // Dinamik uzunluklu dizi (başlangıçta boş)

    // Mapping anahtar-değer (key-value) çiftlerini depolamak için kullanılır
    mapping(uint => string) public list; // numara bir ismi tutacak

    // Mapping kullanım örneği
    function addToList(uint _key, string memory _value) public {
        list[_key] = _value; // numara `_key` engini `_value` olarak tutar
    }

    function getFromList(uint _key) public view returns (string memory) {
        return list[_key];
    }

    // Kullanıcı tanımlı veri türleri (struct)
    struct Human {
        uint id; // `id`'nin türünü belirtmek gereklidir
        string username;
        uint age;
        address userAddress;
    }
    
    // Struct değişkeni
    Human public person1;

    // Struct ile veri ayarlama fonksiyonu
    function setPerson(uint _id, string memory _username, uint _age, address _userAddress) public {
        person1 = Human(_id, _username, _age, _userAddress);
    }

    // Struct verilerini alma fonksiyonu
    function getPerson() public view returns (uint, string memory, uint, address) {
        return (person1.id, person1.username, person1.age, person1.userAddress);
    }

    // Enum tanımlama
    enum TrafficLight {
        Red,    // 0
        Yellow, // 1
        Green   // 2
    }

        // 1 Ether (ETH) = 1,000,000,000 Gwei (10^9 Gwei)
	    // 1 Ether (ETH) = 1,000,000,000,000,000,000 Wei (10^18 Wei)


        // 1 dakika = 60 saniye
		// 1 saat = 60 dakika = 3600 saniye
		// 1 gün = 24 saat = 86400 saniye
		// 1 hafta = 7 gün = 604800 saniye

    // command + k + c   secili hepsini yorum satirina alir
    // command + k + u   yorum satirini kaldirir
}
