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
import 'package:share_plus/share_plus.dart';

class InvestmentPDFScreen extends StatefulWidget {
  final Investment investment;

  const InvestmentPDFScreen({super.key, required this.investment});

  @override
  _InvestmentPDFScreenState createState() => _InvestmentPDFScreenState();
}

class _InvestmentPDFScreenState extends State<InvestmentPDFScreen> {
  String? pdfPath;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _generatePDF(widget.investment);
  }

  /// Generates a PDF document and saves it to local storage
  Future<void> _generatePDF(Investment investment) async {
    try {
      setState(() => isLoading = true);

      final dir = await getApplicationDocumentsDirectory();
      final file = File("${dir.path}/investment_${investment.id}.pdf");

      final pdf = pw.Document();

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Padding(
              padding: const pw.EdgeInsets.all(16),
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
                  _pdfText("Name", investment.name),
                  _pdfText("Description", investment.description),
                  _pdfText("ROI", "${investment.roi}%"),
                  _pdfText("Risk Level", investment.riskLevel.toString()),
                  _pdfText("Duration", investment.duration.toString()),
                  _pdfText("Amount", "₹${investment.amount}"),
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
                    style: const pw.TextStyle(fontSize: 12),
                  ),
                ],
              ),
            );
          },
        ),
      );

      await file.writeAsBytes(await pdf.save());

      setState(() {
        pdfPath = file.path;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error generating PDF: $e")));
    }
  }

  /// Helper method for consistent text formatting in the PDF
  pw.Widget _pdfText(String title, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 3),
      child: pw.Text("$title: $value", style: const pw.TextStyle(fontSize: 14)),
    );
  }

  /// Function to share the PDF using `shareXFiles`
  void _sharePDF() {
    if (pdfPath != null) {
      Share.shareXFiles([
        XFile(pdfPath!),
      ], text: context.localize('investment_document'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.localize('investment_document'),
          style: AppTextStyles.medium(size: 20, color: AppColors.white),
        ),
        iconTheme: const IconThemeData(color: AppColors.white),
        backgroundColor: AppColors.app,
        actions: [
          if (pdfPath != null)
            IconButton(icon: const Icon(Icons.download), onPressed: _sharePDF),
        ],
      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : pdfPath == null
              ? const Center(child: Text("Failed to generate PDF"))
              : PDFView(filePath: pdfPath!),
    );
  }
}
