class RequestFirebase {
  final String itemName;
  final int quantity;

  RequestFirebase({required this.itemName, required this.quantity});

  // Метод для преобразования данных из Firebase в объект RequestFirebase
  factory RequestFirebase.fromMap(Map<dynamic, dynamic> data) {
    return RequestFirebase(
      itemName: data['itemName'] ?? '',
      quantity: data['quantity'] ?? 0,
    );
  }

  // Преобразование объекта в Map для записи в Firebase (если потребуется)
  Map<String, dynamic> toMap() {
    return {
      'itemName': itemName,
      'quantity': quantity,
    };
  }
}
