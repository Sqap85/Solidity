// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Test {
    // 'total' adında bir değişken. Başlangıçta 0, toplam değeri tutmak için kullanılır.
    uint256 public total = 0;
    
    // Ether gönderildiğinde tetiklenen receive fonksiyonu
    receive() external payable {
        // Fallback gibi kullanılabilir, sadece Ether transferi olduğunda çalışır
        fallbackCalled += 1;
    }
    // 'fallbackCalled' değişkeni, fallback fonksiyonunun kaç kez çağrıldığını tutar. Başlangıçta 0.
    uint256 public fallbackCalled = 0;
    
    // 'incrementer' değişkeni, kimin 'inc' fonksiyonunu çağırdığını (isim olarak) tutmak için kullanılır.
    string public incrementer;

    // Fallback fonksiyonu: Kontrata ether gönderildiğinde veya var olmayan bir işlev çağrıldığında tetiklenir.
    // Fallback her çağrıldığında 'fallbackCalled' sayacını 1 artırır.
    fallback() external payable {
        fallbackCalled += 1;
    }

    // 'inc' fonksiyonu: Kontrata belli bir miktar (_amount) ekler ve çağıran kişiyi (_incrementer) kaydeder.
    // Fonksiyonun sonunda güncellenmiş 'total' değerini döner.
    function inc(uint256 _amount, string memory _incrementer) external returns(uint256) {
        total += _amount; // 'total' miktarını günceller
        incrementer = _incrementer; // 'incrementer' değişkenini günceller

        return total; // Güncellenen toplamı döner
    } 
}

contract Caller {
    
    // 'testCall' fonksiyonu: 'Test' kontratındaki 'inc' fonksiyonunu dinamik olarak çağırır.
    // Parametreler: çağırılacak kontrat adresi, miktar (_amount) ve artırıcı (_incrementer).
    // 'call' kullanarak kontrata ulaşır ve sonucu döner.
    function testCall(address _contract, uint256 _amount, string memory _incrementer) external returns (bool, uint256) {
        // 'inc' fonksiyonunu çağırmak için 'abi.encodeWithSignature' ile parametreleri kodlar.
        // 'call' kullanarak fonksiyonu çağırır ve başarı durumunu 'err' ve dönüş verisini 'res' olarak alır.
        (bool err, bytes memory res) = _contract.call(abi.encodeWithSignature("inc(uint256, string)", _amount, _incrementer));

        // Dönen veriyi (res) uint256 olarak çözümler ve '_total' değişkenine atar.
        uint256 _total = abi.decode(res, (uint256));
        
        // Fonksiyon başarılı mı (err) ve güncellenen toplam (_total) değerini döner.
        return (err, _total);
    }

    // 'payToFallback' fonksiyonu: Ether göndererek 'Test' kontratının fallback fonksiyonunu çağırır.
    // Parametre: kontrat adresi (_contract).
    function payToFallback(address _contract) external payable {
        // Kontrata ether gönderir. 'call' yöntemi kullanarak herhangi bir fonksiyon çağırmaz, sadece Ether gönderir.
        (bool err,) = _contract.call{value: msg.value}("");

        // Eğer işlem başarısız olursa (err false dönerse), revert ile işlemi geri alır.
        if(!err) revert();
    }
}