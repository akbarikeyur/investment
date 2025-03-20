import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:investment/core/models/investment.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

Future<String> generateTestPDF(Investment investment) async {
  final dir = await getApplicationDocumentsDirectory();
  final file = File("${dir.path}/test_investment.pdf");
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Text(investment.name);
      },
    ),
  );

  await file.writeAsBytes(await pdf.save());
  return file.path;
}

void main() {
  test("PDF should be generated and stored", () async {
    final investment = Investment(
      id: "1",
      name: "Test Investment",
      amount: 5000,
      roi: 10,
      riskLevel: "Low",
      description: "Test",
      duration: "5 Years",
      longDescription: 'Test Investment long description',
    );

    final path = await generateTestPDF(investment);
    final fileExists = await File(path).exists();

    expect(fileExists, true);
  });
}
