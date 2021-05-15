import 'package:flutter/material.dart';
import 'package:shaboo/components/stateless/loading_widget.dart';

class ImageWithCloseBtn extends StatelessWidget {
  final String url;
  final Function onClose;
  const ImageWithCloseBtn({
    Key key,
    @required this.url,
    @required this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 100,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 100,
              child: this.url != null
                  ? Image.network(
                      this.url,
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(child: LoadingWidget(isImage: true));
                      },
                    )
                  : Image.asset(
                      'assets/icons/book-placeholder.png',
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: Icon(Icons.close_rounded, size: 20, color: Colors.white),
              onPressed: this.onClose,
            ),
          ),
        ],
      ),
    );
  }
}
