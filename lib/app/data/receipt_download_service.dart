import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:salonhub_v2/app/constant/theme.dart';

class ReceiptData {
  const ReceiptData({
    required this.bookingCode,
    required this.appointmentDateLabel,
    required this.paymentMethodName,
    required this.serviceName,
    required this.servicePrice,
    required this.serviceFeePrice,
    required this.totalPrice,
  });

  final String bookingCode;
  final String appointmentDateLabel;
  final String paymentMethodName;
  final String serviceName;
  final int servicePrice;
  final int serviceFeePrice;
  final int totalPrice;
}

class ReceiptDownloadService {
  static const _downloadChannel = MethodChannel('salonhub/receipt_download');

  Future<String> download(ReceiptData receipt) async {
    final bytes = await _buildReceipt(receipt);
    final fileName = 'Bukti_Pembayaran_${receipt.bookingCode}';

    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      final location = await _downloadChannel.invokeMethod<String>(
        'saveReceiptPdf',
        <String, Object>{'fileName': '$fileName.pdf', 'bytes': bytes},
      );

      if (location == null || location.isEmpty) {
        throw StateError('Lokasi penyimpanan tidak ditemukan.');
      }

      return location;
    }

    return FileSaver.instance.saveFile(
      name: fileName,
      bytes: bytes,
      fileExtension: 'pdf',
      mimeType: MimeType.pdf,
    );
  }

  Future<Uint8List> _buildReceipt(ReceiptData receipt) async {
    final document = pw.Document();
    final primaryColor = PdfColor.fromInt(AppColors.primary900.toARGB32());
    final mutedColor = PdfColor.fromInt(AppColors.blueGray500.toARGB32());
    final dividerColor = PdfColor.fromInt(AppColors.blueGray200.toARGB32());

    document.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                width: double.infinity,
                padding: const pw.EdgeInsets.all(20),
                decoration: pw.BoxDecoration(
                  color: primaryColor,
                  borderRadius: pw.BorderRadius.circular(12),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'SALONHUB',
                      style: pw.TextStyle(
                        color: PdfColors.white,
                        fontSize: 11,
                        fontWeight: pw.FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    pw.SizedBox(height: 8),
                    pw.Text(
                      'Bukti pembayaran',
                      style: pw.TextStyle(
                        color: PdfColors.white,
                        fontSize: 22,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 4),
                    pw.Text(
                      'Status pembayaran: LUNAS',
                      style: pw.TextStyle(color: PdfColors.white, fontSize: 11),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 24),
              pw.Text(
                'Masterpiece Barbershop - Haircut styling',
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 16),
              _detailRow(
                'Kode booking',
                receipt.bookingCode,
                isEmphasized: true,
              ),
              pw.SizedBox(height: 8),
              _detailRow('Jadwal', receipt.appointmentDateLabel),
              pw.SizedBox(height: 8),
              _detailRow('Metode pembayaran', receipt.paymentMethodName),
              pw.SizedBox(height: 20),
              pw.Container(height: 1, color: dividerColor),
              pw.SizedBox(height: 20),
              pw.Text(
                'Rincian pembayaran',
                style: pw.TextStyle(
                  fontSize: 14,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 14),
              _priceRow(
                receipt.serviceName,
                _formatRupiah(receipt.servicePrice),
              ),
              pw.SizedBox(height: 10),
              _priceRow(
                'Biaya layanan',
                _formatRupiah(receipt.serviceFeePrice),
              ),
              pw.SizedBox(height: 14),
              pw.Container(height: 1, color: dividerColor),
              pw.SizedBox(height: 14),
              _priceRow(
                'Total pembayaran',
                _formatRupiah(receipt.totalPrice),
                isEmphasized: true,
              ),
              pw.Spacer(),
              pw.Center(
                child: pw.Text(
                  'Terima kasih telah melakukan booking di SalonHub.',
                  style: pw.TextStyle(color: mutedColor, fontSize: 10),
                ),
              ),
            ],
          );
        },
      ),
    );

    return document.save();
  }

  pw.Widget _detailRow(
    String label,
    String value, {
    bool isEmphasized = false,
  }) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(
          width: 132,
          child: pw.Text(
            label,
            style: pw.TextStyle(color: PdfColors.grey700, fontSize: 11),
          ),
        ),
        pw.Expanded(
          child: pw.Text(
            value,
            style: pw.TextStyle(
              fontSize: 11,
              fontWeight: isEmphasized
                  ? pw.FontWeight.bold
                  : pw.FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }

  pw.Widget _priceRow(String label, String price, {bool isEmphasized = false}) {
    final textStyle = pw.TextStyle(
      fontSize: isEmphasized ? 13 : 11,
      fontWeight: isEmphasized ? pw.FontWeight.bold : pw.FontWeight.normal,
    );

    return pw.Row(
      children: [
        pw.Expanded(child: pw.Text(label, style: textStyle)),
        pw.Text(price, style: textStyle),
      ],
    );
  }

  String _formatRupiah(int amount) {
    final digits = amount.toString();
    final formatted = StringBuffer();

    for (var index = 0; index < digits.length; index++) {
      if (index > 0 && (digits.length - index) % 3 == 0) {
        formatted.write('.');
      }
      formatted.write(digits[index]);
    }

    return 'Rp$formatted';
  }
}
