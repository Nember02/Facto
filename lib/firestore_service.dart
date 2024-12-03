import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Получение данных из Firestore
  Future<List<Map<String, dynamic>>> fetchDataFromSpreadsheet(String collectionName) async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection(collectionName).get();
      return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      print('Ошибка при получении данных: $e');
      return [];
    }
  }

  // Добавление данных в Firestore
  Future<void> addDataToSpreadsheet(String collectionName, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collectionName).add(data);
    } catch (e) {
      print('Ошибка при добавлении данных: $e');
    }
  }

  // Обновление данных
  Future<void> updateData(String collectionName, String docId, Map<String, dynamic> newData) async {
    try {
      await _firestore.collection(collectionName).doc(docId).update(newData);
    } catch (e) {
      print('Ошибка при обновлении данных: $e');
    }
  }

  // Удаление данных
  Future<void> deleteData(String collectionName, String docId) async {
    try {
      await _firestore.collection(collectionName).doc(docId).delete();
    } catch (e) {
      print('Ошибка при удалении данных: $e');
    }
  }
}