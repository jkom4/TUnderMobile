import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:file_picker/src/file_picker_result.dart';
import 'package:ftpconnect/ftpconnect.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tunder/model/synthese.dart';
import 'package:tunder/repository/i_synthese_repository.dart';
import 'package:tunder/model/environment.dart';
import '../Model/userSession.dart';

class SyntheseRepository implements ISyntheseRepository {
  static final apiUrl = Environment.apiUrl;
  FTPConnect ftpConnect = FTPConnect(
      '192.168.128.13', user: 'e200851', pass: 'aKkdUP7f');

  SyntheseRepository();

  @override
  Future addSynthese(Synthese synthese) async {
    // je recupere le token dans le secureStorage
    await UserSessionProvider.getInstance!.get(key: "jwtToken").then((
        value) async {
      var json = jsonDecode(value!);
      var token = json['tokenString'];
      Response response = await http.post(Uri.parse('${apiUrl}/Synthese'),
          body: jsonEncode(synthese.toJson()),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "bearer $token"
          });
      if (response.statusCode != 200) {
        String mess = response.statusCode.toString();
        throw Exception('Failed to add synthese {$mess}');
      }
    });
  }

  @override
  Future saveFile(FilePickerResult result) async {
    try {
      File fileToUpload = File(result.files.first.path!);
      await ftpConnect.connect();
      await ftpConnect.changeDirectory('Syntheses');
      await ftpConnect.uploadFile(fileToUpload);
      await ftpConnect.disconnect();
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<List<Synthese>?> getSynthese() async {
    var jwt;
    await UserSessionProvider.getInstance!.get(key: "jwtToken").then((
        value) async {
      jwt = value;
    });

    var json = jsonDecode(jwt!);
    var token = json['tokenString'];
    Response response = await http.get(Uri.parse("$apiUrl/Synthese"), headers: {
      "Content-Type": "application/json",
      "Authorization": "bearer $token"
    });

    if (response.statusCode == 200) {
      Iterable r = jsonDecode(response.body);


      List<Synthese> syntheses = await (jsonDecode(response.body) as List)
          .map((i) => Synthese.fromJson(i))
          .toList();
      return syntheses;
    } else {
      String mess = response.statusCode.toString();
      throw Exception('Failed to fetch syntheses {$mess}');
    }
  }

  @override
  Future downloadFile(String fileName) async {
    try {
      File downloadedFile = await _fileMock(fileName: fileName);
      await ftpConnect.connect();
      await ftpConnect.changeDirectory('Syntheses');
      await ftpConnect.downloadFile(fileName, downloadedFile);
      await ftpConnect.disconnect();
      print(downloadedFile.path);
      return downloadedFile;
    }catch(e){
      print("repository "+ e.toString());
    }

  }

  ///mock a file for the demonstration example
  Future<File> _fileMock({fileName = 'FlutterTest.txt', content = ''}) async {
    final directory = await getApplicationDocumentsDirectory();
    final Directory newDirectory = Directory('${directory.path}/images')..createSync(recursive: true);
    final File file = File('${directory.path}/$fileName');
    await file.writeAsString(content);
    return file;
  }

}

