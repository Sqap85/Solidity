//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StructEnum {

    // Sipariş durumlarını belirten bir enum (numaralı sabit liste)
    enum Status {
        Taken,      // 0: Sipariş alındı
        Preparing,  // 1: Hazırlanıyor
        Boxed,      // 2: Paketlendi
        Shipped     // 3: Gönderildi
    }

    // Siparişin detaylarını tutan bir yapı (struct)
    struct Order {
        address customer;  // Siparişi veren müşteri adresi
        string zipCode;    // Müşterinin posta kodu
        uint256[] products; // Sipariş edilen ürünlerin kimlik numaraları
        Status status;     // Siparişin şu anki durumu
    }

    Order[] public orders;  // Tüm siparişleri saklayan dinamik dizi
    address public owner;   // Kontrat sahibinin adresi

    // Kontratı deploy eden kişi kontratın sahibi olur
    constructor() {
        owner = msg.sender;
    }

    // Yeni bir sipariş oluşturma fonksiyonu
    function createOrder(string memory _zipCode, uint256[] memory _products) external returns(uint256) {
        require(_products.length > 0, "No products.");  // Ürün listesi boş olamaz

        // Yeni sipariş (Order) oluşturuluyor
        Order memory order;
        order.customer = msg.sender;         // Siparişi veren kişi
        order.zipCode = _zipCode;            // Müşterinin verdiği posta kodu
        order.products = _products;          // Ürünlerin kimlik numaraları
        order.status = Status.Taken;         // Sipariş durumu alındı (Taken) olarak ayarlandı
        orders.push(order);                  // Siparişler listesine yeni sipariş ekleniyor

        return orders.length - 1;  // Yeni siparişin ID'sini döner (dizideki index'i)
    }

    // Siparişin durumunu ilerleten fonksiyon
    function advanceOrder(uint256 _orderId) external {
        require(owner == msg.sender, "You are not authorized.");  // Sadece kontrat sahibi bu fonksiyonu çağırabilir
        require(_orderId < orders.length, "Not a valid order id.");  // Geçerli bir sipariş ID'si olmalı

        // Siparişin durumu güncelleniyor
        Order storage order = orders[_orderId];
        require(order.status != Status.Shipped, "Order is already shipped.");  // Sipariş zaten gönderildiyse işlem yapılamaz

        // Sipariş durumunu sırayla bir sonraki aşamaya geçir
        if (order.status == Status.Taken) {
            order.status = Status.Preparing;
        } else if (order.status == Status.Preparing) {
            order.status = Status.Boxed;
        } else if (order.status == Status.Boxed) {
            order.status = Status.Shipped;
        }
    }

    // Bir siparişi detaylarıyla birlikte dönen fonksiyon
    function getOrder(uint256 _orderId) external view returns (Order memory) {
        require(_orderId < orders.length, "Not a valid order id.");  // Geçerli bir sipariş ID'si olmalı
        return orders[_orderId];  // İstenen siparişin tüm detaylarını döner
    }

    // Müşteri, siparişinin posta kodunu güncelleyebilir
    function updateZip(uint256 _orderId, string memory _zip) external {
        require(_orderId < orders.length, "Not a valid order id.");  // Geçerli bir sipariş ID'si olmalı
        Order storage order = orders[_orderId];  // Siparişe erişim
        require(order.customer == msg.sender, "You are not the owner of the order.");  // Siparişi yapan kişi olmalısınız
        order.zipCode = _zip;  // Posta kodunu güncelle
    }

}