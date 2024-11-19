// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// Chainlink Price Feed interface
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
// Chainlink'in fiyat feed'lerini kullanmak için gerekli olan standart arayüzü içe aktarır.
// Bu arayüz, Chainlink node'larından veri almak için kullanılan fonksiyonları sağlar.


contract PriceConsumerV3Sepolia {

    // Fiyat feed'ini tutacak bir değişken tanımlanır. 
    // `AggregatorV3Interface` tipi, Chainlink fiyat feed'leriyle çalışmak için kullanılan bir yapı sağlar.
    AggregatorV3Interface internal priceFeed;

    /**
     * Constructor: Sepolia test ağı için ETH/USD fiyat feed adresi kullanılır.
     */
    constructor() {
        // ETH/USD fiyat feed adresi (Sepolia Testnet)
        priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
    }

    /**
     * ETH/USD fiyatını en son güncellenen haliyle alır.
     */
    function getLatestPrice() public view returns (int) {
        (
            /* uint80 roundID */, // eger virgul ile tum degerleri yazmasaydik hata verirdi cunku latestRoundData() tum verileri dondurur
            int price,
            /* uint startedAt */,
            /* uint timeStamp */,
            /* uint80 answeredInRound */
        ) = priceFeed.latestRoundData();// Chainlink'in en son bilgilerini döndüren fonksiyonudur.
        return price;
    }
}
