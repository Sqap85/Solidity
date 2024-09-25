
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// library , Solidity’de ortak işlevselliklerin ve yardımcı fonksiyonların farklı akıllı sözleşmelerde tekrar kullanılabilir şekilde tanımlandığı bir yapı türüdür. Kütüphaneler, yazılım geliştirme sürecinde modülerliği artırır ve kod tekrarını azaltır. Diğer sözleşmelere doğrudan eklenebilir veya bu sözleşmelerle bağlantılı olarak çalışabilirler.
library Math {
    
    function plus(uint x,uint y) public pure returns(uint){
        return x+y;
    }

    function minus(uint x,uint y) public pure returns(uint){
        return x-y;
    }

    function multi(uint x,uint y) public pure returns(uint){
        return x*y;
    }

    function divide(uint x,uint y) public pure returns(uint){
        return x/y;
    }

    function min(uint x,uint y) public pure returns(uint){
        if (x <= y){
            return x;
        }
        else {
            return y;
        }
    }

        function man(uint x,uint y) public pure returns(uint){
        if (x >= y){
            return x;
        }
        else {
            return y;
        }
    }
}

contract example{

    function plus(uint x,uint y) public pure returns (uint){
        return Math.plus(x, y);
    }

     function minus(uint x,uint y) public pure returns (uint){
        return Math.minus(x, y);
    }

     function multi(uint x,uint y) public pure returns (uint){
        return Math.multi(x, y);
    }

     function divide(uint x,uint y) public pure returns (uint){
        return Math.divide(x, y);
    }

     function min(uint x,uint y) public pure returns (uint){
        return Math.min(x, y);
    }
}
