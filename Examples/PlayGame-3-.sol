// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Game {
    // Oyun katılımcılarının adreslerini tutacak
    address[] public players;
    // Oyunun kazanma ödülü
    uint256 public prizePool;

    // Oyun başladığında tetiklenecek olay
    event GameStarted();
    event WinnerAnnounced(address winner, uint256 amount);

    // Oyuna katılmak için fonksiyon
    function joinGame() external payable {
        require(msg.value > 0, "You must send some Ether to join the game.");
        players.push(msg.sender); // Kullanıcının adresini ekle
        prizePool += msg.value; // Priz havuzunu artır
        emit GameStarted(); // Oyun başladığını bildir
    }

    // Oyunu bitirip kazananı belirleme fonksiyonu
    function endGame() external {
        require(players.length > 0, "No players in the game.");
        require(prizePool > 0, "Prize pool is empty.");

        // Rastgele bir oyuncu seçmek için blok zaman damgasını kullan
        uint256 winnerIndex = random() % players.length;
        address winner = players[winnerIndex];

        // Kazananı ödüllendir
        (bool success, ) = winner.call{value: prizePool}("");
        require(success, "Transfer failed.");

        // Oyun sonunda oyuncuları ve ödülü sıfırla
        emit WinnerAnnounced(winner, prizePool);
        delete players; // Oyuncuları sıfırla
        prizePool = 0; // Ödül havuzunu sıfırla
    }

    // Rastgele sayı üretme fonksiyonu
    function random() private view returns (uint256) {
        return uint256(keccak256(abi.encodePacked(block.prevrandao, block.timestamp, players)));
    }

    // Katılımcıların sayısını döndürmek için bir fonksiyon
    function getPlayersCount() external view returns (uint256) {
        return players.length;
    }
}