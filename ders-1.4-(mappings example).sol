// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract NestedMapping {

    mapping(address => mapping(address => uint256)) public debts;
    // "debts" adında, adresler arası borç ilişkisini kaydeden iki seviyeli bir mapping oluşturuyoruz.
    // İlk adres (msg.sender) borç veren, ikinci adres (_borrower) borç alan kişiyi temsil eder ve son olarak uint256, borç miktarını belirtir.

    function incDebt(address _borrower, uint256 _amount) public {
    // Bu fonksiyon, bir borç alan adresi (_borrower) ve eklenecek borç miktarını (_amount) parametre olarak alır.
        debts[msg.sender][_borrower] += _amount;
        // msg.sender, bu fonksiyonu çağıran kişinin adresini temsil eder. Bu satır, borç verenin (_borrower) borcunu belirtilen miktar kadar artırır.
    }

    function decDebt(address _borrower, uint256 _amount) public {
    // "decDebt" fonksiyonu, borcu azaltmak için kullanılır. Borç alan (_borrower) adresi ve azaltılacak miktarı (_amount) parametre olarak alır.
        require(debts[msg.sender][_borrower] >= _amount, "Not enough debt.");
        // "require" ifadesi ile, borcu azaltmadan önce mevcut borcun azaltılmak istenen miktardan fazla olup olmadığını kontrol ediyoruz. 
        // Eğer borç miktarı yeterli değilse, işlem iptal edilir ve "Not enough debt." hatası döner.
        debts[msg.sender][_borrower] -= _amount;
        // Bu satırda borç, belirtilen miktar kadar azaltılır.
    }

    function getDebt(address _borrower) public view returns (uint256) {
    // "getDebt" fonksiyonu, bir borç alanın (_borrower) mevcut borcunu döner. Bu fonksiyon sadece veriyi görüntülemek için kullanılır (değişiklik yapmaz).
        return debts[msg.sender][_borrower];
        // msg.sender'e borçlu olan (_borrower) adresinin borç miktarı döndürülür.
    }
}
