import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/src/file_picker_result.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tunder/model/synthese.dart';
import 'package:tunder/repository/i_synthese_repository.dart';
import 'package:tunder/model/environment.dart';
import '../Model/userSession.dart';

class SyntheseRepository implements ISyntheseRepository {
  static final apiUrl = Environment.apiUrl;

  SyntheseRepository();

  @override
  Future addSynthese(Synthese synthese) async {
    // je recupere le token dans le secureStorage
    await UserSessionProvider.getInstance!
        .get(key: "jwtToken")
        .then((value) async {
      var json = jsonDecode(value!);
      var token = json['tokenString'];
      Response response = await http.post(
          Uri.parse('${apiUrl}/Syntheses/Synthese'),
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
      final fileName = result.files.first.name!;
      final destination = 'syntheses/$fileName';
      final ref = FirebaseStorage.instance.ref(destination);
      var file = File(result.files.single.path!);
      ref.putFile(file);
      return ref.getDownloadURL();
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  @override
  Future<List<Synthese>?> getSynthese() async {
    var jwt;
    await UserSessionProvider.getInstance!
        .get(key: "jwtToken")
        .then((value) async {
      jwt = value;
    });

    var json = jsonDecode(jwt!);
    var token = json['tokenString'];
    Response response = await http.get(Uri.parse("$apiUrl/Syntheses/Synthese"),
        headers: {
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
      print('Failed to fetch syntheses {$mess}');
    }
  }

  @override
  Future downloadFile(String url) async {
    try {
      final httpsReference = FirebaseStorage.instance.refFromURL(url);
      final dir = await getApplicationDocumentsDirectory();
      final fileName = httpsReference.name;
      final File file = File('${dir.path}/$fileName');
      await httpsReference.writeToFile(file);
      return file;
    } catch (e) {
      print("repository " + e.toString());
    }
  }
}
