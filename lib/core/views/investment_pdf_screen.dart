import 'dart:io';
import 'package:flutter/material.dart';
import 'package:investment/core/config/app_color.dart';
import 'package:investment/core/config/app_extension.dart';
import 'package:investment/core/config/app_textstyle.dart';
import 'package:investment/core/models/investment.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter_pdfview/flutter_pdfview.dart';

class InvestmentPDFScreen extends StatefulWidget {
  final Investment investment;

  InvestmentPDFScreen({required this.investment});

  @override
  _InvestmentPDFScreenState createState() => _InvestmentPDFScreenState();
}

class _InvestmentPDFScreenState extends State<InvestmentPDFScreen> {
  String? pdfPath;

  @override
  void initState() {
    super.initState();
    _generatePDF(widget.investment);
  }

  /// Function to generate PDF dynamically
  Future<void> _generatePDF(Investment investment) async {
    // Save PDF to a temporary directory
    final dir = await getApplicationDocumentsDirectory();
    final file = File("${dir.path}/investment_${investment.id}.pdf");
    final isFileExist = await file.exists();
    if (!isFileExist) {
      final pdf = pw.Document();

      // Define content
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Padding(
              padding: pw.EdgeInsets.all(16),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    "Investment Details",
                    style: pw.TextStyle(
                      fontSize: 24,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Text(
                    "Name: ${investment.name}",
                    style: pw.TextStyle(fontSize: 18),
                  ),
                  pw.Text(
                    "Description: ${investment.description}",
                    style: pw.TextStyle(fontSize: 14),
                  ),
                  pw.Text(
                    "ROI: ${investment.roi}%",
                    style: pw.TextStyle(fontSize: 14),
                  ),
                  pw.Text(
                    "Risk Level: ${investment.riskLevel}",
                    style: pw.TextStyle(fontSize: 14),
                  ),
                  pw.Text(
                    "Duration: ${investment.duration}",
                    style: pw.TextStyle(fontSize: 14),
                  ),
                  pw.Text(
                    "Amount: ₹${investment.amount}",
                    style: pw.TextStyle(fontSize: 14),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Text(
                    "Detailed Information",
                    style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 5),
                  pw.Text(
                    investment.longDescription,
                    textAlign: pw.TextAlign.justify,
                    style: pw.TextStyle(fontSize: 12),
                  ),
                ],
              ),
            );
          },
        ),
      );

      await file.writeAsBytes(await pdf.save());
    }

    setState(() {
      pdfPath = file.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.localize('investment_document'),
          style: AppTextStyles.medium(size: 20, color: AppColors.white),
        ),
        iconTheme: IconThemeData(color: AppColors.white),
        backgroundColor: AppColors.app,
      ),
      body:
          pdfPath == null
              ? Center(child: CircularProgressIndicator())
              : PDFView(filePath: pdfPath!),
    );
  }
}
