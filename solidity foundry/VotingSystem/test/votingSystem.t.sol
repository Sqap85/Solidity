// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/votingSystem.sol";

contract VotingSystemTest is Test {
    votingSystem public voting;
    address owner;
    address user1;
    address user2;

    function setUp() public {
        // Sözleşmeyi kur
        owner = address(this);
        user1 = address(0x1);
        user2 = address(0x2);

        // Yeni oylama sistemi kur
        voting = new votingSystem();
    }

    function testAddCandidate() public {
        // Sadece owner aday ekleyebilir, owner bu olduğu için başarılı olacaktır
        voting.addCandidate("Candidate 1");
        voting.addCandidate("Candidate 2");

        // Adayların sayısını kontrol et
        assertEq(voting.getCandidateCount(), 2);

        // Adayların isimlerini kontrol et
        (string[] memory names, uint[] memory indices) = voting.getAllCandidates();
        assertEq(names[0], "Candidate 1");
        assertEq(names[1], "Candidate 2");
    }

    function testStartVoting() public {
        // Oylama başlatma
        voting.startVoting(10); // 10 dakika

        // Başlatıldıktan sonra aday eklenmemeli
        vm.expectRevert("Voting is already in progress.");
        voting.addCandidate("Candidate 3");

        // Süre geçene kadar oylama aktif olmalı
        vm.warp(block.timestamp + 5 minutes);
        assertTrue(block.timestamp < voting.votingEndTime());
    }

    function testVote() public {
        // Aday ekle ve oylamayı başlat
        voting.addCandidate("Candidate 1");
        voting.addCandidate("Candidate 2");
        voting.startVoting(10); // 10 dakika

        // user1'in oy vermesi
        vm.prank(user1); // user1 adına işlemi yapar
        voting.vote(0);

        // user1 tekrar oy vermeye çalışırsa hata almalı
        vm.expectRevert("You have already voted.");
        vm.prank(user1);
        voting.vote(1);

        // Oy sonuçlarını kontrol et
        (, uint[] memory indices) = voting.getAllCandidates();
        assertEq(voting.getCandidateCount(), 2);
    }

 function testGetWinner() public {
    // Set up candidates
    voting.addCandidate("Candidate 1");
    voting.addCandidate("Candidate 2");

    // Start voting for 10 blocks
    voting.startVoting(10);

    // Simulate votes
    vm.prank(address(1));
    voting.vote(0); // Address 1 votes for Candidate 1

    vm.prank(address(2));
    voting.vote(0); // Address 2 votes for Candidate 1

    // Warp time to end the voting period
    vm.warp(block.timestamp + 11);

    // Finish voting
    voting.finishVoting();

    // Now, getting the winner should work
    (string memory winnerName, uint winnerVoteCount) = voting.getWinner();
    assertEq(winnerName, "Candidate 1");
    assertEq(winnerVoteCount, 2);
}
    

    function testFailVoteWithoutCandidates() public {
        // Oylamayı başlatmaya çalışmadan önce hata almalı
        vm.expectRevert("Invalid candidate index.");
        voting.vote(0);
    }
}