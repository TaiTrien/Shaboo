import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shaboo/constants/ui_constants.dart';

class SupplierScreen extends StatelessWidget {
  final List<dynamic> _imagesOnlineStores = [
    "assets/images/tiki.png",
    "assets/images/shoppee.png",
    "assets/images/laza.png",
  ];

  final List<dynamic> _bookStores = [
    {
      'image': "assets/images/fahasa.jpeg",
      'name': 'Nhà sách Fahasa',
      'location': 'Quận Tân Bình, TP.HCM',
      'closed': '22:00',
    },
    {
      'image': "assets/images/nha_nam.jpeg",
      'name': 'Nhà sách Nhã Nam',
      'location': 'Quận Tân Phú, TP.HCM',
      'closed': '23:00',
    },
    {
      'image': "assets/images/phuong_nam.jpeg",
      'name': 'Nhà sách Phương Nam',
      'location': 'Quận Phú Nhuận, TP.HCM',
      'closed': '22:00',
    },
    {
      'image': "assets/images/kim_dong.jpeg",
      'name': 'Nhà sách Kim Đồng',
      'location': 'Quận 12, TP.HCM',
      'closed': '21:00',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Nhà cung cấp',
          style: kHeadingTextStyle,
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        width: double.infinity,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: kDefaultPaddingVerical, horizontal: kDefaultPaddingHorizontal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cửa hàng online',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Container(
              height: 120,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _imagesOnlineStores.length,
                  itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: kDefaultPaddingVerical, horizontal: 10),
                        child: Container(
                          height: 100,
                          width: 100,
                          child: Image.asset(_imagesOnlineStores[index]),
                        ),
                      )),
            ),
            SizedBox(height: 50),
            Text(
              'Nhà sách',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Expanded(
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                itemCount: _bookStores.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: kDefaultPaddingVerical, horizontal: 10),
                  child: Row(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage(_bookStores[index]['image']),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '${_bookStores[index]['name']}\n',
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            TextSpan(
                              text: '${_bookStores[index]['location']}\n',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            TextSpan(
                              text: '${_bookStores[index]['closed']}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                separatorBuilder: (context, index) => Divider(height: 2, thickness: 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
