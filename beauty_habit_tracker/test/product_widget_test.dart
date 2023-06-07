import 'package:beauty_habit_tracker/utils/product_info/products_static_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:beauty_habit_tracker/products/product_model.dart';
import 'package:beauty_habit_tracker/products/product_display_widgets.dart';

void main() {
  group('test product detail info widget', () {
    String testId = 'test-id';
    ProductModel testModel = ProductModel(
        image: defualtImageLink,
        brand: 'test_brand',
        type: 'test_type',
        name: 'test_name',
        status: 'test_status',
        pAO: 30,
        eXD: defaultMaxTime,
        note: 'my note');

    testWidgets('product name', (tester) async {
      await tester.pumpWidget(ProductName(productModel: testModel));
      expect(find.text('test_name'), findsOneWidget);
      expect(find.text('Name'), findsOneWidget);
    });

    testWidgets('product brand', (tester) async {
      await tester.pumpWidget(ProductBrand(productModel: testModel));
      expect(find.text('test_brand'), findsOneWidget);
      expect(find.text('Brand'), findsOneWidget);
    });

    testWidgets('product type', (tester) async {
      await tester.pumpWidget(ProductType(productModel: testModel));
      expect(find.text('test_type'), findsOneWidget);
      expect(find.text('Type'), findsOneWidget);
    });

    testWidgets('product status', (tester) async {
      await tester.pumpWidget(ProductStatus(productModel: testModel));
      expect(find.text('test_status'), findsOneWidget);
      expect(find.text('Status'), findsOneWidget);
    });

    /**testWidgets('product Image', (tester) async {
      mockNetworkImagesFor(
          () => tester.pumpWidget(ProductImage(productModel: testModel)));
    });
    */

    testWidgets('Product archive date', (tester) async {
      await tester.pumpWidget(ProductArchiveDate(productModel: testModel));
      expect(find.text('Archive date'), findsOneWidget);
      expect(find.text('----/--/--'), findsOneWidget);
      expect(find.byIcon(Icons.calendar_today_rounded), findsOneWidget);
    });

    testWidgets('Product finishe date', (tester) async {
      await tester.pumpWidget(ProductFinishDate(productModel: testModel));
      expect(find.text('Finish date'), findsOneWidget);
      expect(find.text('----/--/--'), findsOneWidget);
      expect(find.byIcon(Icons.calendar_today_rounded), findsOneWidget);
    });

    testWidgets('Product Add date', (tester) async {
      await tester.pumpWidget(ProductAddDate(productModel: testModel));
      expect(find.text('Add date'), findsOneWidget);
      expect(find.text('----/--/--'), findsOneWidget);
      expect(find.byIcon(Icons.calendar_today_rounded), findsOneWidget);
    });

    testWidgets('Product open date', (tester) async {
      await tester.pumpWidget(ProductOpenDate(productModel: testModel));
      expect(find.text('Open date'), findsOneWidget);
      expect(find.text('----/--/--'), findsOneWidget);
      expect(find.byIcon(Icons.calendar_today_rounded), findsOneWidget);
    });
    testWidgets('Product EXD', (tester) async {
      await tester.pumpWidget(ProductEXD(productModel: testModel));
      expect(find.text('Estimated EXD'), findsOneWidget);
      expect(find.text('----/--/--'), findsOneWidget);
      expect(find.byIcon(Icons.calendar_today_rounded), findsOneWidget);
    });

    testWidgets('Product PAO', (tester) async {
      await tester.pumpWidget(ProductPAO(productModel: testModel));
      expect(find.text('Estimated PAO'), findsOneWidget);
      expect(find.text('30 months'), findsOneWidget);
    });

    testWidgets('Product Note', (tester) async {
      await tester.pumpWidget(MaterialApp(
          home: Material(child: ProductNote(productModel: testModel))));
      expect(find.text('my note'), findsOneWidget);
    });

    testWidgets('Update Remainder', (tester) async {
      await tester.pumpWidget(MaterialApp(
          home: Material(
              child:
                  UpdateReminder(productId: testId, productModel: testModel))));
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Review the Updated Information'), findsOneWidget);
      expect(find.text('status:test_status'), findsOneWidget);
      expect(find.text('open date:----/--/--'), findsOneWidget);
      expect(find.text('PAO:30 months'), findsOneWidget);
      expect(find.text('Estimated EXD:----/--/--'), findsOneWidget);
      expect(find.text('Customized Note:my note'), findsOneWidget);
      expect(find.byType(TextButton), findsNWidgets(2));
      await tester.tap(find.widgetWithText(TextButton, 'No, go back'));
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsNothing);
      
      expect(tester, meetsGuideline(textContrastGuideline));
      expect(tester, meetsGuideline(androidTapTargetGuideline));
    });

    testWidgets('Space', (tester) async {
      await tester.pumpWidget(const Space());
      expect(find.byType(SizedBox), findsOneWidget);
      expect(tester, meetsGuideline(textContrastGuideline));
      expect(tester, meetsGuideline(androidTapTargetGuideline));
    });

    /**
    testWidgets('Update Remainder with yes', (tester) async {

      await tester.pumpWidget(MaterialApp(
          home: Material(
              child: Scaffold(
                  body: UpdateReminder(
                      productId: testId, productModel: testModel)))));
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Review the Updated Information'), findsOneWidget);
      expect(find.text('status:test_status'), findsOneWidget);
      expect(find.text('open date:----/--/--'), findsOneWidget);
      expect(find.text('PAO:30 months'), findsOneWidget);
      expect(find.text('Estimated EXD:----/--/--'), findsOneWidget);
      expect(find.text('Customized Note:my note'), findsOneWidget);
      expect(find.byType(TextButton), findsNWidgets(2));
      await tester
          .tap(find.widgetWithText(TextButton, 'Yes, confirm to update'));
      await tester.pumpAndSettle();
      expect(find.byWidget(const CircularProgressIndicator()), findsOneWidget);
    });
    */
    
  });
}
