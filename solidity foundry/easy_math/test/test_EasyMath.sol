// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

// Forge-std Test kütüphanesini içe aktarıyoruz, test yazmak için gereklidir.
import "forge-std/Test.sol";
// Test edilen EasyMath kontratını içe aktarıyoruz.
import "../src/EasyMath.sol";

// ContractTest adında bir test kontratı oluşturuyoruz.
contract ContractTest is Test {
    // EasyMath kontratının bir örneğini tanımlıyoruz.
    EasyMath easy;

    // Testlerden önce çalışacak olan ayar fonksiyonu.
    function setUp() public {
        // Her testten önce yeni bir EasyMath kontratı oluşturuyoruz.
        easy = new EasyMath();
    }

    // Basit bir test fonksiyonu.
    function testEasy() public {
        // EasyMath kontratındaki mul fonksiyonunu çağırıyoruz ve sonucu x değişkenine atıyoruz.
        uint x = easy.mul(3, 3, 3);
        // x'in 3 * 3 * 3 değerine eşit olduğunu kontrol ediyoruz.
        assertEq(x, 3 * 3 * 3);
    }

    // Bu test fonksiyonu, hata durumu test etmeyi amaçlıyor.
    function testFailEasy() public {
        // EasyMath kontratındaki mul fonksiyonunu çağırıyoruz ve sonucu x değişkenine atıyoruz.
        uint x = easy.mul(3, 3, 3);
        // x'in 1 * 1 * 1 değerine eşit olmadığını kontrol ediyoruz.
        // Bu testin geçmesi için x'in 1'e eşit olmaması gerekiyor.
        assertEq(x, 1 * 1 * 1);
    }
}