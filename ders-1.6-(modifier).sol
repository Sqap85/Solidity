//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//  modifier
//•	Şartlar belirleyip bu şartların sağlanmaması durumunda fonksiyonun çalışmasını engelleyebilirler.
//•	Modifiers, bir fonksiyonun giriş ve çıkışına özel kurallar ekleyebilir.

contract Modifier {

    enum Status {
        Taken,
        Preparing,
        Boxed,
        Shipped
    }

    struct Order {
        address customer;
        string zipCode;
        uint256[] products;
        Status status;
    }

    Order[] public orders;
    address public owner;
    uint256 public txCount;

    constructor() {
        owner = msg.sender;
    }

    function createOrder(string memory _zipCode, uint256[] memory _products) checkProducts(_products) incTx external returns(uint256) {
        Order memory order;
        order.customer = msg.sender;
        order.zipCode = _zipCode;
        order.products = _products;
        order.status = Status.Taken;
        orders.push(order);
        
        return orders.length - 1;
    }

    function advanceOrder(uint256 _orderId) checkOrderId(_orderId) onlyOwner external {
        Order storage order = orders[_orderId];
        require(order.status != Status.Shipped, "Order is already shipped.");

        if (order.status == Status.Taken) {
            order.status = Status.Preparing;
        } else if (order.status == Status.Preparing) {
            order.status = Status.Boxed;
        } else if (order.status == Status.Boxed) {
            order.status = Status.Shipped;
        }
    }

    function getOrder(uint256 _orderId) checkOrderId(_orderId) external view returns (Order memory) {
        return orders[_orderId];
    }

    function updateZip(uint256 _orderId, string memory _zip) checkOrderId(_orderId) onlyCustomer(_orderId) incTx external {
        Order storage order = orders[_orderId];
        order.zipCode = _zip;
    }

    // Modifier: Ürün listesinin boş olmamasını kontrol eder.
    modifier checkProducts(uint256[] memory _products) {
        require(_products.length > 0, "No products.");
        _;  // Fonksiyonun geri kalan kısmının çalışacağı yer
    }

    // Modifier: Geçerli bir sipariş ID'sinin kontrolünü yapar.
    modifier checkOrderId(uint256 _orderId) {
        require(_orderId < orders.length, "Not a valid order id.");
        _;  // Fonksiyonun geri kalan kısmının çalışacağı yer
    }

    // Modifier: Fonksiyon çağrıldığında işlem sayısını artırır.
    modifier incTx {
        _;  // Fonksiyonun geri kalan kısmının çalışacağı yer
        txCount++;  // İşlem sayısını artır
    }

    // Modifier: Sadece kontrat sahibinin erişimine izin verir.
    modifier onlyOwner {
        require(owner == msg.sender, "You are not authorized.");
        _;  // Fonksiyonun geri kalan kısmının çalışacağı yer
    }

    // Modifier: Siparişin sahibi olmayanların işlem yapmasını engeller.
    modifier onlyCustomer(uint256 _orderId) {
        require(orders[_orderId].customer == msg.sender, "You are not the owner of the order.");
        _;  // Fonksiyonun geri kalan kısmının çalışacağı yer
    }

}