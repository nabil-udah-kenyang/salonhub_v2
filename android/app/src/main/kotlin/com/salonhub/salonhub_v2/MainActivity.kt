package com.salonhub.salonhub_v2

import android.content.ContentValues
import android.os.Build
import android.os.Environment
import android.provider.MediaStore
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val receiptDownloadChannel = "salonhub/receipt_download"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            receiptDownloadChannel,
        ).setMethodCallHandler { call, result ->
            if (call.method != "saveReceiptPdf") {
                result.notImplemented()
                return@setMethodCallHandler
            }

            val fileName = call.argument<String>("fileName")
            val bytes = call.argument<ByteArray>("bytes")

            if (fileName.isNullOrBlank() || bytes == null) {
                result.error(
                    "invalid_arguments",
                    "Nama file atau isi PDF tidak tersedia.",
                    null,
                )
                return@setMethodCallHandler
            }

            try {
                result.success(saveReceiptToDownloads(fileName, bytes))
            } catch (exception: Exception) {
                result.error(
                    "save_failed",
                    exception.message ?: "Gagal menyimpan bukti pembayaran.",
                    null,
                )
            }
        }
    }

    private fun saveReceiptToDownloads(fileName: String, bytes: ByteArray): String {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.Q) {
            throw UnsupportedOperationException(
                "Unduh bukti pembayaran memerlukan Android 10 atau lebih baru.",
            )
        }

        val safeName = fileName.replace(Regex("[\\\\/:*?\\\"<>|]"), "_")
        val values = ContentValues().apply {
            put(MediaStore.Downloads.DISPLAY_NAME, safeName)
            put(MediaStore.Downloads.MIME_TYPE, "application/pdf")
            put(MediaStore.Downloads.RELATIVE_PATH, Environment.DIRECTORY_DOWNLOADS)
            put(MediaStore.Downloads.IS_PENDING, 1)
        }
        val resolver = contentResolver
        val uri = resolver.insert(MediaStore.Downloads.EXTERNAL_CONTENT_URI, values)
            ?: throw IllegalStateException("Folder Download tidak tersedia.")

        try {
            resolver.openOutputStream(uri)?.use { output ->
                output.write(bytes)
            } ?: throw IllegalStateException("File PDF tidak dapat ditulis.")

            values.clear()
            values.put(MediaStore.Downloads.IS_PENDING, 0)
            resolver.update(uri, values, null, null)
            return uri.toString()
        } catch (exception: Exception) {
            resolver.delete(uri, null, null)
            throw exception
        }
    }
}
