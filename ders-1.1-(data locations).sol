// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

    // 1.	storage:
	// •	Kalıcı Depolama: Değişkenler blockchain üzerinde kalıcı olarak saklanır ve tüm işlemlerden sonra bu verilere erişilebilir. Bu nedenle, storage kullanımı daha maliyetlidir çünkü blockchain’de veri tutmak işlemci ve gaz açısından pahalıdır.
	// •	Durum Değişkenleri: Sözleşmede tanımlanan durum (state) değişkenleri storage’da saklanır. Durum değişkenleri işlemler arasında kalıcıdır.
	// •	Veri Kalıcılığı: storage alanına yazılan veriler, sözleşmenin ömrü boyunca kalır ve blockchain’de kaydedilir.
	// 2.	memory:
	// •	Geçici Depolama: Değişkenler yalnızca fonksiyon çağrısı sırasında geçici olarak saklanır ve fonksiyon çağrısı sona erdiğinde bu veriler silinir. memory daha ucuzdur çünkü yalnızca işlem sırasında kullanılır ve kalıcı olarak blockchain’e yazılmaz.
	// •	Fonksiyon Parametreleri ve Lokal Değişkenler: Fonksiyon parametreleri ve lokal değişkenler genellikle memory alanında saklanır.
	// •	Kısa Ömürlü Veri: Sadece işlem süresince veri saklamak için kullanılır. İşlem sonlandığında memory’deki veri kaybolur.
    // 3.	calldata:
	// •	Yalnızca okunabilir ve dışarıdan gelen parametreler için kullanılır. Kalıcı değil, ancak değiştirilemez.

/*
           Kontrat           <----                  Kontrata yapılan çağrı
           -------                                      -------------
    Kontrat depolama alanı           Fonksiyon için ayrılan hafıza ve çağrıdaki data alanı

    memory:          Geçici hafıza
    storage:         Kalıcı hafıza
    calldata:        Çağrıdaki argümanlar

    bytes, string, array, struct

    * Değer tipleri (uint, int, bool, bytes32) kontrat üzerinde storage, 
      fonksiyon içinde memory'dir
    
    * mapping'ler her zaman kontrat üzerinde tanımlanır ve storage'dadır.
*/

struct Student {
    uint8 age;
    uint16 score;
    string name;
}

contract School {
    uint256 totalStudents = 0;              // storage
    mapping(uint256 => Student) students;   // storage

    function addStudent(string calldata name, uint8 age, uint16 score) external {
        uint256 currentId = totalStudents++;
        students[currentId] = Student(age, score, name); 
    }

    function changeStudentInfoStorage(
        uint256 id,                 // memory
        string calldata newName,    // calldata
        uint8 newAge,               // memory
        uint16 newScore             // memory
    ) external {
        Student storage currentStudent = students[id];

        currentStudent.name = newName;
        currentStudent.age = newAge;
        currentStudent.score = newScore;
    }

    /**
        @dev Bu işe yaramayacaktır, çünkü oluşturulan currentStudent ömrü
        fonksiyonun bitişine kadar olan bir değişken ve fonksiyon tamamlandığında
        silinecektir
    */
    function changeStudentInfoMemory (
        uint256 id,                 // memory
        string calldata newName,    // calldata
        uint8 newAge,               // memory
        uint16 newScore             // memory
    ) external view {
        Student memory currentStudent = students[id];

        currentStudent.name = newName;
        currentStudent.age = newAge;
        currentStudent.score = newScore;
    }

    function getStudentName(uint256 id) external view returns(string memory) { 
        return students[id].name;
    }
}
