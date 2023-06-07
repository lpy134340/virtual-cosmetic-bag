import 'dart:io';
import 'package:beauty_habit_tracker/utils/product_info/products_static_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'product_model.dart';
import 'package:uuid/uuid.dart';

Future<void> addProduct(ProductModel model) async {
  try {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    String productsListPath = '/product_list_per_user';
    var dataVar = FirebaseFirestore.instance
        .collection(productsListPath)
        .doc(userId)
        .collection('/products')
        .doc()
        .withConverter<ProductModel>(
      fromFirestore: (snapshot, _) {
        return ProductModel.fromJson(snapshot.data()!);
      },
      toFirestore: (productModel, _) {
        return productModel.toJson();
      },
    );

    await dataVar.set(
      ProductModel(
          brand: model.brand,
          type: model.type,
          name: model.name,
          status: model.status,
          eXD: model.eXD,
          image: model.image,
          pAO: model.pAO,
          openOn: model.openOn,
          finishedOn: model.finishedOn,
          archivedOn: model.archivedOn,
          addOn: model.addOn,
          note: model.note),
    );
  } catch (error) {
    debugPrint(error.toString());
  }
}

Future<ProductModel?> getProduct(String productId) async {
  try {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    String productsListPath = '/product_list_per_user';
    final model = await FirebaseFirestore.instance
        .collection(productsListPath)
        .doc(userId)
        .collection('/products')
        .doc(productId)
        .withConverter<ProductModel>(
            fromFirestore: (snapshot, _) =>
                ProductModel.fromJson(snapshot.data()!),
            toFirestore: (productModel, _) {
              return productModel.toJson();
            })
        .get();
    return model.data()!;
  } catch (error) {
    debugPrint(error.runtimeType.toString());
    debugPrint(error.toString());
    return null;
  }
}

Future<void> updateProduct(String productId, ProductModel productModel) async {
  try {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    String productsListPath = '/product_list_per_user';
    var dataVar = FirebaseFirestore.instance
        .collection(productsListPath)
        .doc(userId)
        .collection('/products')
        .doc(productId)
        .withConverter<ProductModel>(
      fromFirestore: (snapshot, _) {
        return ProductModel.fromJson(snapshot.data()!);
      },
      toFirestore: (productModel, _) {
        return productModel.toJson();
      },
    );

    await dataVar.set(
      ProductModel(
          brand: productModel.brand,
          type: productModel.type,
          name: productModel.name,
          status: productModel.status,
          eXD: productModel.eXD,
          image: productModel.image,
          pAO: productModel.pAO,
          openOn: productModel.openOn,
          finishedOn: productModel.finishedOn,
          archivedOn: productModel.archivedOn,
          addOn: productModel.addOn,
          note: productModel.note),
    );
  } catch (error) {
    debugPrint(error.toString());
  }
}

Future<void> openProduct(
    String productId, ProductModel product, Timestamp openDate) async {
  try {
    product.open(openDate);
    updateProduct(productId, product);
  } catch (error) {
    debugPrint(error.toString());
  }
}

Future<void> archiveProduct(
    String productId, ProductModel product, Timestamp finishDate) async {
  try {
    if (finishDate != defaultMaxTime) {
      product.finish(finishDate);
    }
    product.archive();
    updateProduct(productId, product);
  } catch (error) {
    debugPrint(error.toString());
  }
}

Stream<QuerySnapshot<Map<String, dynamic>>> getStream() {
  String userId = FirebaseAuth.instance.currentUser!.uid;
  String productsListPath = '/product_list_per_user';

  return FirebaseFirestore.instance
      .collection(productsListPath)
      .doc(userId)
      .collection('/products')
      .orderBy('EXD')
      .get()
      .asStream();
}

Stream<QuerySnapshot<Map<String, dynamic>>> getStreamArchived() {
  String userId = FirebaseAuth.instance.currentUser!.uid;
  String productsListPath = '/product_list_per_user';

  return FirebaseFirestore.instance
      .collection(productsListPath)
      .doc(userId)
      .collection('/products')
      .orderBy('Archived_Date')
      .get()
      .asStream();
}

Future<String?> uploadImage(File file) async {
  try {
    String imageName = const Uuid().v4();
    String userId = FirebaseAuth.instance.currentUser!.uid;
    Reference referenceRoot = FirebaseStorage.instance.ref();

    final referenceImage = referenceRoot
        .child('user_products_images')
        .child(userId)
        .child(imageName);
    await referenceImage.putFile(file);
    var url = await referenceImage.getDownloadURL();
    return url;
  } catch (error) {
    // ignore: avoid_print
    print(error.toString());
    return null;
  }
}

Future deleteProduct(productId) async {
  try {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    String productsListPath = '/product_list_per_user';
    FirebaseFirestore.instance
        .collection(productsListPath)
        .doc(userId)
        .collection('/products')
        .doc(productId)
        .delete();
  } catch (error) {
    debugPrint(error.runtimeType.toString());
    debugPrint(error.toString());
  }
}
