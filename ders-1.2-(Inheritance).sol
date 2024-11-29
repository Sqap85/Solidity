// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

	// •	Miras (inheritance), bir sözleşmenin başka bir sözleşmenin fonksiyon ve değişkenlerini devralmasını sağlar.
	// •	Public ve internal değişkenler ve fonksiyonlar miras alınır, private olanlar miras alınmaz.
	// •	Solidity’de çoklu miras mümkündür ve C3 Linearization ile çözülür.
	// •	Constructor’lar miras alınan sözleşmelerde de çağrılabilir.
	// •	super anahtar kelimesi, üst sınıfların fonksiyonlarına erişim sağlar.

contract A{
    uint public x;
    uint public y;
                        // virtual ilerde miras alinirsa degistirilebilir olmasini saglar
    function setX(uint _x) virtual  public {
        x = _x;
    }

     function setY(uint _y) public {
        y = _y;
    }
}
        // A kontratini miras aldik
contract B is A{
                        // override ile miras alinan fonksiyonu guncelledigimizi soyluyoruz
    function setX(uint _x) override public {
        x = _x + 2;
    }
}

contract Human{
    function sayHello() public pure virtual returns (string memory){
        return "The 85 is biggest but you are not member pussy";
    }
}
    //          Human contratini miras aldik
contract superHuman is Human {

    function sayHello() public pure override returns(string memory){
        return "The 85 is biggest amcik! you are a member!";
    }

    function welcomeMsg(bool isMember) public pure returns (string memory){
        return isMember ? sayHello() : Human.sayHello();
        //          eger uye ise mevcut contrattaki mesaji yaz degilse Humandaki say hello contratindaki say helloyu cagir
    }
}
// OpenZeppelin'den Ownable sözleşmesini import ediyoruz.
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

//          Ownable i intheritance(miras) aliyoruz.
contract Wallet is Ownable {

    // Constructor'da miras aldığımız Ownable sözleşmesine owner adresini göndermemiz gerekiyor.
    constructor(address initialOwner) Ownable(initialOwner) {
        // Bu sözleşmeyi dağıtan kişiyi sözleşmenin sahibi olarak ayarlıyoruz.
    }

    // Fallback ve receive fonksiyonları Ether alımını sağlar.
    fallback() external payable {}
    receive() external payable {}

    // Ether göndermek için bir fonksiyon
    // Sadece sözleşmenin sahibi (owner) bu fonksiyonu çağırabilir.
    function sendEther(address payable to, uint amount) onlyOwner public onlyOwner {
        require(amount <= address(this).balance, "Insufficient balance");
        to.transfer(amount);
    }

    // Sözleşmedeki Ether bakiyesini gösterir.
    function showBalance() public view returns (uint) {
        return address(this).balance;
    }
}
