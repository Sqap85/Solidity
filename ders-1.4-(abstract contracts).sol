// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//Soyut sözleşmeler (abstract contracts), Solidity’de belirli bir temel yapı veya davranış tanımlamak için kullanılan özel bir sözleşme türüdür. Bu sözleşmeler, diğer sözleşmelere miras vererek onları özelleştirmeye olanak tanır. Soyut sözleşmeler, tam olarak uygulanmamış (yani bazı fonksiyonları tanımlayıp uygulamamış) fonksiyonlar içerebilir ve bu nedenle doğrudan dağıtılamazlar.

// Soyut ödeme stratejisi sözleşmesi
abstract contract PaymentStrategy {
    function pay(uint256 amount) external virtual;
}

contract BitcoinPayment is PaymentStrategy {
    function pay(uint256 amount) external override {
        // Bitcoin ile ödeme işlemleri burada yapılır
        // Örnek olarak, belirli bir adresle entegre bir işlem yapıldığı varsayılsın
        // Bitcoin ödemesi için gereken mantık
        // Eş zamanlı olarak blockchain ile etkileşim
        // Bu kısım sadece bir örnek, gerçek Bitcoin işlemleri için ayrı bir API/servis kullanılmalıdır
    }
}

contract EthereumPayment is PaymentStrategy {
    function pay(uint256 amount) external override {
        // Ethereum ile ödeme işlemleri burada yapılır
        // Örnek olarak, bir Ethereum cüzdanına para göndermek için gereken mantık
        // transfer fonksiyonu ile gönderim yapılabilir
        payable(msg.sender).transfer(amount); // Örnek, kullanıcıdan alınan Ether'in kendisine gönderilmesi
    }
}

contract CreditCardPayment is PaymentStrategy {
    function pay(uint256 amount) external override {
        // Kredi kartı ile ödeme işlemleri burada yapılır
        // Kredi kartı ödemesi için bir üçüncü taraf ödeme işleme API'sine bağlanılabilir
        // Bu kısım, gerçek dünyada bir ödeme sağlayıcı (Stripe, PayPal vb.) ile entegre edilmelidir
    }
}

contract PaymentProcessor {
    PaymentStrategy public paymentStrategy;

    // Ödeme stratejisini ayarlamak için bir fonksiyon
    function setPaymentStrategy(PaymentStrategy _strategy) external {
        paymentStrategy = _strategy;
    }

    // Belirli bir miktarı ödemek için kullanılan fonksiyon
    function processPayment(uint256 amount) external {
        require(paymentStrategy != PaymentStrategy(address(0)), "Payment strategy not set");
        paymentStrategy.pay(amount);
    }
}
	// 1.	PaymentStrategy (Soyut Sözleşme):
	// •	Bu sözleşme, pay adında bir soyut fonksiyon tanımlar. Bu fonksiyonu miras alan (inherit) sözleşmeler, kendi ödeme mantıklarını burada uygulamak zorundadır.
	// 2.	BitcoinPayment, EthereumPayment, CreditCardPayment:
	// •	Her biri PaymentStrategy sözleşmesini miras alır ve pay fonksiyonunu kendi mantıklarıyla implement eder.
	// •	Bu stratejiler, farklı ödeme yöntemlerinin mantığını içerecek şekilde tasarlanmıştır.
	// 3.	PaymentProcessor Sözleşmesi:
	// •	Bu sözleşme, bir ödeme stratejisi belirlemek için kullanılır ve belirlenen stratejiyi kullanarak ödemeleri işler.
	// •	setPaymentStrategy fonksiyonu ile istenilen ödeme stratejisi ayarlanabilir.
	// •	processPayment fonksiyonu, belirlenen stratejiyi kullanarak belirli bir miktarda ödeme işlemi gerçekleştirir.
