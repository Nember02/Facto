import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'request_firebase.dart';

class OrderViewPage extends StatelessWidget {
  final String group;

  const OrderViewPage({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    String backgroundImage = group == 'PIR' ? 'assets/images/pir_back.jpg' : 'assets/images/cg_back.jpg'; // Выбираем картинку в зависимости от группы

    final DatabaseReference databaseReference = FirebaseDatabase.instance.ref('requests');

    return Scaffold(
      appBar: AppBar(
        title: Text('$group'),
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          // Фоновое изображение
          Positioned.fill(
            child: Image.asset(
              backgroundImage,
              fit: BoxFit.cover,
            ),
          ),
          // Полупрозрачный затемняющий слой
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5), // 50% прозрачности
            ),
          ),
          // Контент страницы
          StreamBuilder<DatabaseEvent>(
            stream: databaseReference.onValue, // Подписываемся на изменения
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Ошибка: ${snapshot.error}'));
              }

              if (!snapshot.hasData || snapshot.data == null) {
                return const Center(child: Text('Нет данных для отображения.'));
              }

              final data = snapshot.data!.snapshot.value as Map<dynamic, dynamic>?;

              if (data == null) {
                return const Center(child: Text('Нет данных.'));
              }

              List<RequestFirebase> requestList = [];
              data.forEach((key, value) {
                requestList.add(RequestFirebase.fromMap(value));
              });

              return ListView.builder(
                itemCount: requestList.length,
                itemBuilder: (context, index) {
                  final request = requestList[index];
                  return ListTile(
                    title: Text(request.itemName, style: TextStyle(color: Colors.white)),
                    subtitle: Text('Quantity: ${request.quantity}', style: TextStyle(color: Colors.white70)),
                    onTap: () {
                      // Обработка нажатия на элемент
                    },
                    tileColor: Colors.grey[800],
                  );
                },
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.grey[850],
    );
  }
}
