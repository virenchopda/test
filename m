import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share/share.dart';
import 'package:http/http.dart' as http;

class GeneratePDF extends StatefulWidget {
  const GeneratePDF({super.key});

  @override
  State<GeneratePDF> createState() => _GeneratePDFState();
}

class _GeneratePDFState extends State<GeneratePDF> {
  final List chatList = [
    "User1: Hello!",
    "User2: Hi, how are you?",
    "User1: I'm good, thanks. How about you?",
    "User2: Doing great, thanks for asking!",
    "User1: What are you up to?",
    "User2: Would you like me to show a full working example using your path, like you can copy-paste it? If yes, send me your image path or tell me if it's local or network "
  ];

  Uint8List? logobytes;
  PdfImage? _logoImage;
  final pdf = pw.Document();

  @override
  void initState() {
    super.initState();
    loadAssetImage();
    loadNetworkImage();
  }

  loadAssetImage() async {
    ByteData _bytes = await rootBundle.load('assets/avtar.jpg');
    logobytes = _bytes.buffer.asUint8List();
    setState(() {
      try {
        _logoImage = PdfImage.file(pdf.document, bytes: logobytes!);
      } catch (e) {
        print("catch--  $e");
        logobytes = null;
        _logoImage = null;
      }
    });
  }

  pw.MemoryImage? networkImg;
  Future loadNetworkImage() async {
    final response = await http.get(Uri.parse(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR8ayVmuByL8KA5XXe4JURb8AEtfCVvQVaiHg&s'));
    networkImg = pw.MemoryImage(response.bodyBytes);
  }

  Future<void> _generatePDF() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.ListView.separated(
            itemCount: chatList.length,
            separatorBuilder: (pw.Context context, int index) =>
                pw.SizedBox(height: 10),
            itemBuilder: (context, index) {
              return pw.Row(
                mainAxisAlignment: index % 2 == 0
                    ? pw.MainAxisAlignment.end
                    : pw.MainAxisAlignment.start,
                children: [
                  if (index % 2 == 1)
                    pw.Container(
                      width: 40,
                      height: 40,
                      decoration: const pw.BoxDecoration(
                        shape: pw.BoxShape.circle,
                        color: PdfColors.white,
                      ),
                      child: logobytes != null
                          ? pw.ClipOval(
                              child: pw.Image(pw.MemoryImage(logobytes!)),
                            )
                          : pw.Container(),
                    ),
                  pw.SizedBox(width: 15),
                  pw.Align(
                    alignment: index % 2 == 0
                        ? pw.Alignment.centerRight
                        : pw.Alignment.centerLeft,
                    child: pw.Container(
                      color: index % 2 == 0
                          ? PdfColors.blue300
                          : PdfColors.green300,
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.all(10),
                        child: pw.Text(
                          chatList[index],
                          style: const pw.TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                  pw.SizedBox(width: 15),
                  if (index % 2 == 0)
                    pw.Builder(
                      builder: (pw.Context context) {
                        return pw.SizedBox(
                          width: 40,
                          height: 40,
                          child: networkImg != null
                              ? pw.ClipOval(
                                  child: pw.Image(networkImg!),
                                )
                              : pw.Container(),
                        );
                      },
                    ),
                ],
              );
            },
          );
        },
      ),
    );

    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/chat_list.pdf');
      await file.writeAsBytes(await pdf.save());
      Share.shareFiles([file.path], text: "text");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('PDF saved to ${file.path}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error generating PDF: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Generate PDF")),
      body: Center(
        child: ElevatedButton(
          onPressed: _generatePDF,
          child: const Text("Generate PDF"),
        ),
      ),
    );
  }
}
