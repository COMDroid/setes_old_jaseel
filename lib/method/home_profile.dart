import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:setes_mobile/module/api_init.dart';
import 'package:setes_mobile/module/gb_var.dart';
import 'package:setes_mobile/screen/home.dart';
import 'package:setes_mobile/widget/home_profile.dart';
import 'package:http/http.dart' as http;

onTapProfilePic(context) {
  if (gbUser['img'] == null) {
    onTapProfilepicEdit(
      context,
    );
  } else {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const UpdateProfileWarningPopup(),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }
}

onTapProfilepicEdit(context) {
  showDialog<void>(
    context: context,
    builder: (BuildContext context2) {
      return const AlertDialog(
        title: Text('Choose Media Type'),
        content: ProfilePicEditWarningPopup(),
      );
    },
  );
}

updateProfilePic(type, context) async {
  try {
    final ImagePicker _picker = ImagePicker();
    final image = await _picker.pickImage(
      source: type == "Files" ? ImageSource.gallery : ImageSource.camera,
    );
    if (image != null) {
      var filePath = image.path;
      var request = http.MultipartRequest(
          'POST', setApi("myprofile?user_id=" + gbUserId));
      // request.headers.addAll({"key": key, "user_id": userId});
      http.MultipartFile multipartFile =
          await http.MultipartFile.fromPath('img', filePath);
      request.files.add(multipartFile);
      http.StreamedResponse response = await request.send();
      var res = await http.Response.fromStream(response);
      if (res.statusCode == 200) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      }
    }
  } catch (e) {
    rethrow;
  }
}
