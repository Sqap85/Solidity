// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

	// •Kontratı deploy ederken bir şifre giriyorsunuz. Bu şifre karma olarak saklanıyor.
	// •Daha sonra login fonksiyonu ile kullanıcı şifresini doğrulamaya çalışıyor. Girilen şifre tekrar hash’e dönüştürülüp, daha önce saklanan hash ile karşılaştırılıyor.
	// •Eğer hash’ler eşleşirse, fonksiyon true döner ve giriş başarılı olur. Eşleşmezse, false döner ve giriş başarısız olur.

contract IfElse{


    bytes32 private hashedPassword;

constructor(string memory _password){

    hashedPassword = keccak256(abi.encode(_password));

}

function login(string memory _password) public view returns (bool){

    if (hashedPassword == keccak256(abi.encode(_password))) { return true;}

    else { return false; }

}


}
