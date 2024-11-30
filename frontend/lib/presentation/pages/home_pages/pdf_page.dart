// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:khidma/constatnts/constants.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class PdfDownloader extends StatefulWidget {
  const PdfDownloader({Key? key}) : super(key: key);

  @override
  State<PdfDownloader> createState() => _PdfDownloaderState();
}

class _PdfDownloaderState extends State<PdfDownloader> {
  bool _isDownloading = false;
  double _downloadProgress = 0.0;

  Future<void> _downloadPdf(String url, String fileName) async {
    setState(() {
      _isDownloading = true;
      _downloadProgress = 0.0;
    });

    try {
      // Get the application documents directory
      // final directory = await getApplicationDocumentsDirectory();
      final directory = await getDownloadsDirectory();
      final filePath = '${directory!.path}/$fileName';

      // Use Dio to download the file
      final dio = Dio();
      await dio.download(
        url,
        filePath,
        onReceiveProgress: (received, total) {
          setState(() {
            _downloadProgress = received / total;
          });
        },
      );

      setState(() {
        _isDownloading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Download completed successfully')),
      );

      // Optionally, open the file after downloading (requires additional packages)
      _showOpenFileDialog(filePath);
    } catch (e) {
      print(e.toString());
      setState(() {
        _isDownloading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Download failed: $e')),
      );
    }
  }

  void _showOpenFileDialog(String filePath) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Open File'),
          content: const Text(
              'The file has been downloaded. Do you want to open it?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Close the dialog
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _openFile(filePath); // Open the file
              },
              child: const Text('Open'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _openFile(String filePath) async {
    final result = await OpenFile.open(filePath);
    if (result.type == ResultType.error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error opening file: ${result.message}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const pdfUrl = '$RESUME_URL/Application_Page_Design_Mockup.pdf';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Download PDF'),
      ),
      body: Center(
        child: _isDownloading
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Downloading...'),
                  const SizedBox(height: 10),
                  LinearProgressIndicator(value: _downloadProgress),
                ],
              )
            : ElevatedButton(
                onPressed: () => _downloadPdf(pdfUrl, 'boussahaborhanedinecv.pdf'),
                child: const Text('Download PDF'),
              ),
      ),
    );
  }
}
