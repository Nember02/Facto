import 'package:flutter/material.dart';
import 'firestore_service.dart';

class SpreadsheetViewPage extends StatefulWidget {
  @override
  _SpreadsheetViewPageState createState() => _SpreadsheetViewPageState();
}

class _SpreadsheetViewPageState extends State<SpreadsheetViewPage> {
  final FirestoreService _firestoreService = FirestoreService();
  List<Map<String, dynamic>> _spreadsheetData = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final data = await _firestoreService.fetchDataFromSpreadsheet('spreadsheets');
      setState(() {
        _spreadsheetData = data;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка загрузки данных: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _addData() async {
    // Пример добавления данных
    await _firestoreService.addDataToSpreadsheet('spreadsheets', {
      'name': 'Новая запись',
      'value': DateTime.now().toString(),
    });
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Данные из Firestore'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _loadData,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          // Устанавливаем цвет фона или изображение
          color: Colors.blueGrey[50], // Светлый серо-голубой фон
          // Чтобы добавить фоновое изображение, можно использовать:
          // image: DecorationImage(
          //   image: NetworkImage('URL_изображения'),
          //   fit: BoxFit.cover, // Настройка растяжения изображения
          // ),
        ),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: _spreadsheetData.length,
                itemBuilder: (context, index) {
                  final item = _spreadsheetData[index];
                  return ListTile(
                    title: Text(item['name'] ?? 'Без названия'),
                    subtitle: Text(item['value']?.toString() ?? ''),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addData,
        child: Icon(Icons.add),
      ),
    );
  }
}
