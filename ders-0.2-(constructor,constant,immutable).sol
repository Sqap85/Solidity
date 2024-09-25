// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Constructor{

    // Sabit bir değer atanır, derleme sırasında belirlenir
    uint256 public constant FIXED_VALUE = 100;

    // Token ismi sabit olarak atanır
    string public constant TOKEN_NAME = "MyToken";

    // Dağıtım sırasında bir değer atanacak, daha sonra değiştirilemez
    address public immutable OWNER;

    constructor() {
        OWNER = msg.sender;  // Sözleşme sahibi olarak dağıtan kişi atanır
    

}
}
