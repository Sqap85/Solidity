// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract votingSystem {

    address private owner;

    // Oylamanın bitiş zamanı
    uint public votingEndTime;

    // Sözleşme sahibini belirleme
    constructor() {
        owner = msg.sender;
    }

    // Aday yapısı (Struct)
    struct Candidate {
        string name;
        uint voteCount;
    }

    // Adayların dizisi
    Candidate[] candidates;

    // Kullanıcıların oy verip vermediğini kontrol eden mapping
    mapping(address => bool) public hasVoted;

    // Aday ekleme fonksiyonu (sadece sözleşme sahibi ekleyebilir)
    function addCandidate(string memory _name) external onlyOwner {
        require(votingEndTime == 0, "Voting is already in progress.");
        candidates.push(Candidate(_name, 0));
    }

    function removeCandidate(uint _candidateIndex) external onlyOwner {
        require(_candidateIndex < candidates.length, "Invalid candidate index.");
        
        // Eğer silinmek istenen aday son aday ise, doğrudan pop ile sil.
        if (_candidateIndex == candidates.length - 1) {
            candidates.pop();
        } else {
            // Aksi halde, silinecek adayın yerine son adayı taşı ve sonra son adayı sil.
            candidates[_candidateIndex] = candidates[candidates.length - 1];
            candidates.pop(); // Son öğeyi sil
        }
    }

// Aday isimlerini ve indeks numaralarını döndüren fonksiyon
function getAllCandidates() external view returns (string[] memory names, uint[] memory indices) {
    uint candidateCount = candidates.length;
    names = new string[](candidateCount);
    indices = new uint[](candidateCount);

    for (uint i = 0; i < candidateCount; i++) {
        names[i] = candidates[i].name; // Adayın ismini al
        indices[i] = i;                // Adayın indeks numarasını ata
    }
}

    // Kullanıcıların oy vermesi için fonksiyon
    function vote(uint _candidateIndex) external hasNotVotedBefore votingActive {
        require(_candidateIndex < candidates.length, "Invalid candidate index.");
        
        // Oy verme işlemi
        candidates[_candidateIndex].voteCount += 1;

        // Oy veren kişiyi işaretle
        hasVoted[msg.sender] = true;
    }

    // Oylamanın sonucunu hesaplayan fonksiyon
    function getWinner() external view votingEnded returns (string memory winnerName, uint winnerVoteCount) {
        uint winningVoteCount = 0;
        uint winningCandidateIndex = 0;

        // En çok oyu alan adayı bul
        for (uint i = 0; i < candidates.length; i++) {
            if (candidates[i].voteCount > winningVoteCount) {
                winningVoteCount = candidates[i].voteCount;
                winningCandidateIndex = i;
            }
        }

        return (candidates[winningCandidateIndex].name, winningVoteCount);
    }

    // Aday sayısını döndüren fonksiyon
    function getCandidateCount() public view returns (uint) {
        return candidates.length;
    }

    // // Belirli bir adayın bilgilerini döndüren fonksiyon
    // function getCandidate(uint _candidateIndex) public view returns (string memory name, uint voteCount) {
    //     require(_candidateIndex < candidates.length, "Invalid candidate index.");
    //     name = candidates[_candidateIndex].name;
    //     voteCount = candidates[_candidateIndex].voteCount;
    // }

    // Oylamayı başlatma (sadece sözleşme sahibi)
    function startVoting(uint _durationInMinutes) external onlyOwner {
        require(votingEndTime <= block.timestamp, "Voting is already in progress.");

        // Oylamanın bitiş zamanını ayarla
        votingEndTime = block.timestamp + (_durationInMinutes * 1 minutes);

    }

    // Oylamayı bitirme (sadece sözleşme sahibi)
    function finishVoting() external onlyOwner votingActive {
        votingEndTime = block.timestamp; // Oylama bittiğinde sıfırla
    }

    // Oylama başlamış ve aktif mi kontrolü
    modifier votingActive() {
        require(block.timestamp < votingEndTime && votingEndTime != 0, "Voting is not active.");
        _;
    }

    // Oylamanın bitip bitmediğini kontrol eden modifier
    modifier votingEnded() {
        require(votingEndTime > 0 && block.timestamp >= votingEndTime, "Voting is still ongoing.");
        _;
    }

    // Sadece bir kez oy vermeyi sağlayan modifier
    modifier hasNotVotedBefore() {
        require(!hasVoted[msg.sender], "You have already voted.");
        _;
    }

    // Sadece sözleşme sahibinin belirli işlemleri yapmasını sağlayan modifier
    modifier onlyOwner() {
        require(owner == msg.sender, "You are not the owner.");
        _;
    }
}