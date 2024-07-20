import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';



/// Represents Homepage for Navigation
class PDFViewScreen extends StatefulWidget {
  const PDFViewScreen({super.key, required this.path});
  final String path;

  @override
  _PDFViewScreenState createState() => _PDFViewScreenState();
}

class _PDFViewScreenState extends State<PDFViewScreen> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview CV', style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold
        ),),
        leading: const BackButton(
            color: Colors.white
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: SfPdfViewer.network(
        widget.path,
        key: _pdfViewerKey,
      ),
    );
  }
}