import 'package:file_picker/file_picker.dart';
import 'package:tunder/model/cours.dart';
import 'package:tunder/model/synthese.dart';

abstract class ISyntheseRepository {

  Future addSynthese(Synthese synthese);
  Future saveFile(FilePickerResult result);
  Future downloadFile(String FileName);
  Future<List<Synthese>?> getSynthese();
}