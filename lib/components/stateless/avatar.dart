import 'package:flutter/material.dart';
import 'package:shaboo/constants/api_constants.dart';

class Avatar extends StatelessWidget {
  final String avatarUrl;
  final double radius;
  final Function onPress;
  const Avatar({
    Key key,
    @required this.avatarUrl,
    this.radius = 60.0,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onPress ?? () {},
      child: CircleAvatar(
        radius: radius,
        backgroundColor: Colors.white,
        child: CircleAvatar(
          child: Align(
            alignment: Alignment.bottomRight,
            child: onPress != null
                ? CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 12.0,
                    child: onPress != null ? Icon(Icons.camera_alt, size: 15.0, color: Color(0xFF404040)) : null,
                  )
                : Container(),
          ),
          radius: radius - 2 ?? 58.0,
          backgroundImage: avatarUrl != '' && avatarUrl != null
              ? NetworkImage(avatarUrl?.substring(0, 6) == 'avatar' ? (kPrefixUploadImageUrl + avatarUrl) : avatarUrl)
              : AssetImage(
                  'assets/images/default-avatar.png',
                ),
        ),
      ),
    );
  }
}
