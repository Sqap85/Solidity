// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Example {
    event LogData(address indexed sender, uint value, uint blockNumber, uint timestamp, address origin, bytes data);

    function exampleFunction() public payable {
        // msg.sender: Fonksiyonu çağıran adres
        address caller = msg.sender;

        // tx.origin: İşlemi başlatan adres
        address originCaller = tx.origin;

        // msg.value: Gönderilen Ether miktarı
        uint amountSent = msg.value;

        // block.number: Mevcut bloğun numarası
        uint currentBlock = block.number;

        // block.timestamp: Mevcut blok zaman damgası
        uint currentTime = block.timestamp;

        // msg.data: Gönderilen veri
        bytes memory data = msg.data;

        // Olayı yayınla
        emit LogData(caller, amountSent, currentBlock, currentTime, originCaller, data);
    }

    function getTransactionInfo() public view returns (
        address, // caller
        address, // origin
        uint,    // amountSent
        uint,    // currentBlock
        uint     // currentTime
    ) {
        // msg.value burada kullanılmaz çünkü bu fonksiyon "view" olarak tanımlıdır.
        return (msg.sender, tx.origin, 0, block.number, block.timestamp); // msg.value yerine 0 döndürülüyor.
    }

    // Ether almak için bir fonksiyon
    receive() external payable {
        emit LogData(msg.sender, msg.value, block.number, block.timestamp, tx.origin, "");
    }

    // Bilinmeyen bir fonksiyon çağrıldığında çalışır
    fallback() external {
        emit LogData(msg.sender, 0, block.number, block.timestamp, tx.origin, "");
    }
}