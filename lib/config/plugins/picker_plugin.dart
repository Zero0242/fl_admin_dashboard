import 'package:file_picker/file_picker.dart';

class PickerPlugin {
  static Future<PlatformFile?> pickImage() async {
    final picker = FilePicker.platform;
    final result = await picker.pickFiles(
      allowMultiple: false,
      dialogTitle: 'Seleccionar Archivo',
      type: FileType.image,
    );

    return result?.files.first;
  }
}
