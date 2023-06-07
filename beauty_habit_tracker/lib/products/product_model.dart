import 'package:beauty_habit_tracker/utils/product_info/products_static_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String image;
  String brand;
  String type;
  String name;
  String status;
  Timestamp? addOn;
  Timestamp? openOn;
  int pAO;
  Timestamp? eXD;
  Timestamp? archivedOn;
  Timestamp? finishedOn;
  String? note;

  ProductModel({
    required this.image,
    required this.brand,
    required this.type,
    required this.name,
    required this.status,
    required this.pAO,
    required this.eXD,
    this.addOn,
    this.openOn,
    this.finishedOn,
    this.archivedOn,
    this.note,
  });

  factory ProductModel.generateNewProduct(
      String brand,
      String type,
      String name,
      String status,
      String image,
      int pAO,
      Timestamp openOn,
      String note) {
    ProductModel model = ProductModel(
        image: image,
        brand: brand,
        type: type,
        name: name,
        status: status,
        pAO: pAO,
        openOn: openOn,
        addOn: Timestamp.now(),
        note: note,
        eXD: null,
        archivedOn: defaultMaxTime,
        finishedOn: defaultMaxTime);

    model.setEXD();
    return model;
  }

  void setEXD() {
    if (status == 'Sealed') {
      eXD = Timestamp.fromDate(
          addOn!.toDate().add(const Duration(days: 36 * 30)));
    }
    if (status == 'Opened') {
      eXD = Timestamp.fromDate(openOn!.toDate().add(Duration(days: pAO * 30)));
    }
  }

  void open(Timestamp openDate) {
    status = 'Opened';
    openOn = openDate;
  }

  void finish(Timestamp finishDate) {
    finishedOn = finishDate;
  }

  void setPao(int period) {
    pAO = period;
  }

  void archive() {
    status = 'Archived';
    archivedOn = Timestamp.now();
  }

  bool isOpen() {
    return status == 'Opened';
  }

  bool isSealed() {
    return status == 'Sealed';
  }

  bool isArchived() {
    return status == 'Archived';
  }

  factory ProductModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return ProductModel(
      image: data?['Image'],
      brand: data?['Brand'],
      type: data?['Type'],
      name: data?['Name'],
      status: data?['Status'],
      pAO: data?['Estimated_PAO'],
      addOn: data?['Add_Date'],
      archivedOn: data?['Archived_Date'],
      eXD: data?['EXD'],
      finishedOn: data?['Finished_Date'],
      note: data?['Customized Note'],
      openOn: data?['Open_Date'],
    );
  }

  ProductModel.fromJson(Map<String, Object?> json)
      : this(
          image: json['Image'] as String,
          brand: json['Brand'] as String,
          type: json['Type'] as String,
          name: json['Name'] as String,
          status: json['Status'] as String,
          pAO: json['Estimated_PAO'] as int,
          addOn: json['Add_Date'] as Timestamp?,
          archivedOn: json['Archived_Date']! as Timestamp?,
          eXD: json['EXD']! as Timestamp?,
          finishedOn: json['Finished_Date']! as Timestamp?,
          note: json['Customized Note']! as String?,
          openOn: json['Open_Date']! as Timestamp?,
        );

  Map<String, Object?> toJson() {
    return {
      "Image": image,
      "Brand": brand,
      "Type": type,
      "Name": name,
      "Status": status,
      "Add_Date": addOn,
      "Open_Date": openOn,
      "Estimated_PAO": pAO,
      "EXD": eXD,
      "Archived_Date": archivedOn,
      "Finished_Date": finishedOn,
      "Customized Note": note,
    };
  }
}
