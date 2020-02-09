import 'package:carrefour/model/item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemService {
  final firestore = Firestore.instance;

  Future<void> addItem(String product, String quantity) async {
    var productPascalcase = product.substring(0, 1).toUpperCase() +
        product.substring(1).toLowerCase();

    return await firestore.collection('items').document().setData(
        {'product': productPascalcase, 'quantity': quantity, 'checked': false});
  }

  Future<void> toggleCheck(Item item) async {
    return await firestore
        .collection('items')
        .document(item.id)
        .updateData({'checked': !item.checked});
  }

  Future<void> delete(Item item) async {
    return await firestore.collection('items').document(item.id).delete();
  }

  Future<void> deleteAll() async {
    var batch = firestore.batch();

    return firestore.collection('items').getDocuments().then((value) {
      value.documents.forEach((doc) {
        batch.delete(doc.reference);
      });

      return batch.commit();
    });
  }
}
