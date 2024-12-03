import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'request_firebase.dart';  // Импортируем модель данных

class ReportSubmitPage extends StatefulWidget {
  final String group;

  const ReportSubmitPage({super.key, required this.group});

  @override
  _ReportSubmitPageState createState() => _ReportSubmitPageState();
}

class _ReportSubmitPageState extends State<ReportSubmitPage> {
  final DatabaseReference databaseReference = FirebaseDatabase.instance.ref('requests');
  String? selectedItem; // Выбранный элемент
  String quantity = ""; // Введенное количество

  @override
  Widget build(BuildContext context) {
    String backgroundImage = widget.group == 'PIR' ? 'assets/images/pir_back.jpg' : 'assets/images/cg_back.jpg'; // Выбираем картинку в зависимости от группы

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
        title: const Text('Send Report'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImage), // Устанавливаем фоновое изображение
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // Затемнение фона
            Container(
              color: Colors.black.withOpacity(0.5), // Затемнение на 50%
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Список предметов
                  Expanded(
                    child: StreamBuilder<DatabaseEvent>(
                      stream: databaseReference.onValue,
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
                              title: Text(
                                request.itemName,
                                style: const TextStyle(color: Colors.white),
                              ),
                              trailing: Radio<String>(
                                value: request.itemName,
                                groupValue: selectedItem,
                                onChanged: (String? value) {
                                  setState(() {
                                    selectedItem = value;
                                  });
                                },
                              ),
                              onTap: () {
                                setState(() {
                                  selectedItem = request.itemName;
                                });
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  // Поле для ввода количества и кнопка
                  Row(
                    children: [
                      // Поле ввода количества
                      Expanded(
                        flex: 3,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          style: const TextStyle(color: Colors.white), // Цвет текста
                          decoration: InputDecoration(
                            labelText: 'Quantity',
                            labelStyle: const TextStyle(color: Colors.grey), // Цвет текста метки
                            hintText: 'Write Quantity',
                            hintStyle: const TextStyle(color: Colors.grey), // Цвет подсказки
                            filled: true,
                            fillColor: Colors.grey[850], // Цвет фона поля ввода
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(color: Colors.grey[700]!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(color: Colors.blue),
                            ),
                          ),
                          onChanged: (value) {
                            quantity = value;
                          },
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      // Кнопка подтверждения
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          onPressed: () {
                            if (selectedItem != null && quantity.isNotEmpty) {
                              _sendReport(selectedItem!, int.parse(quantity));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please, choose item and write quantity'),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green, // Цвет кнопки
                            foregroundColor: Colors.white, // Цвет текста
                            padding: const EdgeInsets.symmetric(vertical: 14.0), // Увеличение высоты кнопки
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0), // Закругленные углы
                            ),
                          ),
                          child: const Text(
                            'Send',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[850],
    );
  }

  void _sendReport(String itemName, int quantity) {
    // Отправка данных в ветку 'done'
    final DatabaseReference doneReference = FirebaseDatabase.instance.ref('done');

    doneReference.push().set({
      'itemName': itemName,
      'quantity': quantity,
      'group': widget.group,
    }).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Successfully written in "done"')),
      );
      setState(() {
        selectedItem = null;
        this.quantity = "";
      });
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка при отправке: $error')),
      );
    });
  }
}
