// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/*
    Interfaces (arayuz):
    OOP' deki Polymorphism konseptinin uygulanma bicimlerinden biridir.

    class lar arasindaki etkilesim icin bir standart olusturur.
    solidity' de class = contracts

     Interfaces Ne İşe Yarar?
	1.	Standartlaşma: Arayüzler, belirli bir standarda uyan akıllı sözleşmelerin fonksiyonlarını tanımlar. Örneğin, ERC-20 standardı bir token sözleşmesinde hangi fonksiyonların bulunması gerektiğini belirtir (transfer, balanceOf, approve gibi). Başka sözleşmeler, bu standart fonksiyonları kullanarak farklı ERC-20 tokenlarıyla kolayca etkileşime geçebilirler.
	2.	Sözleşmeler Arası Etkileşim: Bir arayüz, başka bir sözleşmenin belirli fonksiyonlarını çağırmamıza olanak tanır. Arayüzü kullanarak bir akıllı sözleşmenin iç detaylarını bilmeden o sözleşmenin fonksiyonlarına erişebilirsin. Örneğin, bir ERC-20 token sözleşmesi ile etkileşime girmek için onun kodunu bilmen gerekmez; sadece arayüzünü (örneğin, IERC20) kullanarak fonksiyonları çağırabilirsin.
	3.	Kodun Yeniden Kullanımı ve Güvenliği: Arayüzler, akıllı sözleşme geliştirme sırasında kodun daha modüler ve güvenli olmasını sağlar. Arayüzler sadece fonksiyon imzalarını tanımlar, bu fonksiyonların nasıl uygulandığı başka bir sözleşmede bulunur. Bu sayede farklı sözleşmelerde aynı arayüzü kullanarak değişiklik yapılabilir.
	4.	Bağımsız Implementasyon: Arayüzler bir uygulamanın (implementation) nasıl olması gerektiğini zorunlu kılmaz, sadece hangi fonksiyonların olması gerektiğini belirtir. Aynı arayüz, farklı şekillerde uygulanabilir (örneğin, ERC-20 standardını takip eden farklı token sözleşmeleri olabilir). Bu, geliştiricilere esneklik sağlar.
*/
// Basit bir ERC-20 interface tanımı  
    interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
}

// Başka bir kontrat içinde interface kullanımı
contract MyTokenContract {
    IERC20 public token; // token adinda bir ierc20 olusturduk. Bu değişken, ERC-20 token standardına uyan bir kontratı temsil eder. Başka bir deyişle, token değişkeni, geçerli bir ERC-20 token kontrat adresine işaret eden bir göstericidir.

    constructor(address _tokenAddress) {
        token = IERC20(_tokenAddress); //	•	IERC20(_tokenAddress): Bu ifade, _tokenAddress adresindeki bir ERC-20 token kontratını IERC20 arayüzü aracılığıyla sarar. Böylece, bu adresi kullanarak ERC-20 fonksiyonlarına erişim sağlanabilir. Yani bu adresin gerçekten bir ERC-20 token kontratı olduğu varsayılır.
    }//token = ...: Token kontrat adresini token değişkenine atar. Artık bu değişken üzerinden ERC-20 token kontratına erişebilir ve onunla işlem yapabilirsin (örneğin token.transfer(...) gibi).

    function checkBalance(address account) public view returns (uint256) {
        return token.balanceOf(account);
    }

    function sendTokens(address recipient, uint256 amount) public returns (bool) {
        return token.transfer(recipient, amount);
    }
}

// ERC-721 standardı için bir arayüz tanımı
interface IERC721 {
    function balanceOf(address owner) external view returns (uint256);
    function ownerOf(uint256 tokenId) external view returns (address);
    function transferFrom(address from, address to, uint256 tokenId) external;
    function approve(address to, uint256 tokenId) external;
    function getApproved(uint256 tokenId) external view returns (address);
}

// ERC-721 tokenlarına erişim sağlayan bir sözleşme
contract MyNFTContract {
    IERC721 public nft; // NFT olarak kullanılacak bir ERC-721 kontratı

    constructor(address _nftAddress) {
        nft = IERC721(_nftAddress); // Geçerli bir ERC-721 kontrat adresi ile başlatır
    }

    // Belirli bir adresin sahip olduğu NFT sayısını kontrol etme
    function checkNFTBalance(address owner) public view returns (uint256) {
        return nft.balanceOf(owner);
    }

    // Belirli bir token'ın sahibi olup olmadığını kontrol etme
    function checkOwnerOfToken(uint256 tokenId) public view returns (address) {
        return nft.ownerOf(tokenId);
    }

    // Token transferi
    function transferNFT(address to, uint256 tokenId) public {
        address owner = nft.ownerOf(tokenId);
        require(owner == msg.sender, "You are not the owner of this NFT");
        nft.transferFrom(owner, to, tokenId); // NFT'yi transfer eder
    }

    // Token'a onay verme
    function approveNFT(address to, uint256 tokenId) public {
        address owner = nft.ownerOf(tokenId);
        require(owner == msg.sender, "You are not the owner of this NFT");
        nft.approve(to, tokenId); // Belirli bir adresin NFT'yi almasına izin verir
    }
}