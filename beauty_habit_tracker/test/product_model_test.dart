import 'package:beauty_habit_tracker/utils/product_info/products_static_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:beauty_habit_tracker/products/product_model.dart';

void main() {
  group('product model test', () {
    final addTimeForSealed = Timestamp.fromDate(DateTime(2022, 12, 6));
    var sealedModel = ProductModel(
        brand: "test-brand",
        name: 'test- name',
        type: 'test -type',
        note: 'test - note',
        status: 'Sealed',
        pAO: 30,
        image: defualtImageLink,
        eXD: defaultMaxTime,
        addOn: addTimeForSealed);

    final addTimeForOpened = Timestamp.fromDate(DateTime(2022, 11, 8));
    final openTimeForOpened = Timestamp.fromDate(DateTime(2022, 12, 6));
    var openedModel = ProductModel(
        addOn: addTimeForOpened,
        brand: "test-brand",
        name: 'test- name',
        type: 'test -type',
        note: 'test - note',
        status: 'Opened',
        pAO: 30,
        image: defualtImageLink,
        openOn: openTimeForOpened,
        eXD: defaultMaxTime);

    // ignore: unused_local_variable
    final addTimeForOpen = openedModel.addOn!;

    test('factory generate new product', () {
      var model = ProductModel.generateNewProduct(
          'testBrand',
          'testType',
          'testName',
          'Sealed',
          defualtImageLink,
          3,
          defaultMaxTime,
          'my note - for test');
      expect(model.runtimeType, ProductModel);
      expect(model.status, 'Sealed');
      expect(model.openOn, defaultMaxTime);
      expect(model.brand, 'testBrand');
      expect(model.type, 'testType');
      expect(model.name, 'testName');
      expect(model.image, defualtImageLink);
      expect(model.pAO, 3);
      expect(model.note, 'my note - for test');
      expect(model.archivedOn, defaultMaxTime);
      expect(model.finishedOn, defaultMaxTime);
      expect(
          model.eXD,
          Timestamp.fromDate(
              model.addOn!.toDate().add(const Duration(days: 36 * 30))));
    });

    test('open product', () {
      expect(sealedModel.isOpen(), false);
      sealedModel.open(Timestamp.now());
      expect(sealedModel.isOpen(), true);
    });
  });
}
