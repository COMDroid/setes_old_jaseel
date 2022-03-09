import 'package:flutter/material.dart';
import 'package:setes_mobile/method/home_profile.dart';
import 'package:setes_mobile/module/api_init.dart';
import 'package:setes_mobile/module/gb_var.dart';
import 'package:setes_mobile/screen/profile_picture.dart';

class UpdateProfileWarningPopup extends StatelessWidget {
  const UpdateProfileWarningPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: SingleChildScrollView(
        child: ListBody(
          children: [
            ListTile(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfilePicturePage(),
                  ),
                );
              },
              title: Row(
                children: const [
                  SizedBox(width: 20),
                  Icon(Icons.remove_red_eye, color: Colors.black45),
                  SizedBox(width: 20),
                  Text("View", style: TextStyle(color: Colors.black45)),
                ],
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                onTapProfilepicEdit(context);
              },
              title: Row(
                children: const [
                  SizedBox(width: 20),
                  Icon(Icons.edit, color: Colors.black45),
                  SizedBox(width: 20),
                  Text("Edit", style: TextStyle(color: Colors.black45)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilePicEditWarningPopup extends StatelessWidget {
  const ProfilePicEditWarningPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListBody(
        children: <Widget>[
          for (var i = 0; i < 2; i++)
            ListTile(
              title: Text(i == 0 ? "Files" : "Camera"),
              onTap: () async {
                updateProfilePic(i == 0 ? "Files" : "Camera", context);
              },
            ),
        ],
      ),
    );
  }
}

class HomeProfilePicture extends StatelessWidget {
  const HomeProfilePicture({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTapProfilePic(context),
      child: Container(
        width: 80,
        height: 80,
        margin: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.all(Radius.circular(40)),
        ),
        child: gbUser['img'] == null
            ? const Icon(Icons.person, size: 60, color: Colors.white)
            : ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(40)),
                child: Image.network(
                  setImgProfile(gbUser["_id"] + "/" + gbUser["img"]),
                  fit: BoxFit.cover,
                  width: 50,
                  height: 50,
                ),
              ),
      ),
    );
  }
}
