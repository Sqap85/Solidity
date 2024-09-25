// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Mapping: keyType => valueType şeklinde kullanılır. 
// Burada keyType genellikle basit veri tipleri olurken (uint, address, bool vb.),
// valueType her türlü veri tipi olabilir (uint, string, struct, mapping vb.).

contract Mapping {

    // Bu mapping, bir adresin kayıtlı olup olmadığını tutar.
    // Bir adres için bool değeri döner: true (kayıtlı), false (kayıtlı değil).
    mapping(address => bool) public registered;

    // Bu mapping, bir kullanıcının favori sayısını tutar.
    // Anahtar olarak adres, değer olarak int256 (pozitif veya negatif tam sayı) kullanılır.
    mapping(address => int256) public favNums;  

    // Kayıt işlemi yapan fonksiyon.
    // Kullanıcının favori sayısını (_favNum) parametre olarak alır.
    function register(int256 _favNum) public {

        // Kullanıcının önceden kayıtlı olup olmadığını kontrol eder.
        // Eğer kayıtlıysa, "user registered before." hatası döner.
        require(!IsRegistered(), "user registered before.");
        
        // Eğer kayıtlı değilse, kullanıcının adresini registered mapping'e ekler ve true yapar.
        // Köşeli parantezler [], Solidity’deki mapping veri yapısının anahtar-değer (key-value) erişimini ifade eder.
        registered[msg.sender] = true;
        //  msg.sender adresini registered mapping’inde anahtar olarak kullanarak o anahtara karşılık gelen değeri true olarak ayarlar.
        
        // Kullanıcının favori sayısını favNums mapping'ine ekler.
        favNums[msg.sender] = _favNum;
    }

    // Kullanıcının kayıtlı olup olmadığını dönen yardımcı fonksiyon.
    // msg.sender (işlemi çağıran adres) mapping'de kayıtlıysa true döner.
    function IsRegistered() public view returns (bool) {
        return registered[msg.sender];
    }

    // Kullanıcının kayıtlarını silen fonksiyon.
    function deleteRegistered() public {

        // Kullanıcının kayıtlı olup olmadığını kontrol eder. Eğer kayıtlı değilse, "user not registered" hatası döner.
        require(IsRegistered(), "user not registered");

        // Kullanıcının adresini registered mapping'inden siler (false yapar).
        delete registered[msg.sender];
        
        // Kullanıcının favori sayısını favNums mapping'inden siler.
        delete favNums[msg.sender];
    }
}
