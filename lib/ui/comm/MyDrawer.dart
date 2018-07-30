import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('Gank', style: TextStyle(color: Colors.white)),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  'http://thirdwx.qlogo.cn/mmopen/vi_32/jTjqKarzMIpzHibISRqtxKGic430ibXgiaA9rHScQSltqyQjXXtfWWSojWAXxCibnAHYGBiapLJvfrxQFUuDGTwMxZjg/132'),
            ),
            otherAccountsPictures: <Widget>[
              GestureDetector(
                child: Icon(Icons.settings, color: Colors.white),
                onTap: () => Navigator.of(context).pushNamed('/setting'),
              )
            ],
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: ExactAssetImage('images/lake.jpg'),
              ),
            ),
          ),
          MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: Expanded(
                child: ListView(
                  children: drawerList.map((item) {
                    return ListTile(
                      leading: Icon(item.icon),
                      title: Text(item.title),
                      onTap: () {
                        if (item.route.length > 0) {
                          Navigator.of(context).pushNamed(item.route);
                        }
                      },
                    );
                  }).toList(),
                ),
              )),
        ],
      ),
    );
  }
}

class DrawerMenuItem {
  final IconData icon;
  final String title;
  final String route;

  const DrawerMenuItem(this.icon, this.title, this.route);
}

const List<DrawerMenuItem> drawerList = <DrawerMenuItem>[
  const DrawerMenuItem(Icons.android, 'Android', '/android'),
  const DrawerMenuItem(Icons.apps, 'iOS', '/ios'),
  const DrawerMenuItem(Icons.code, '前端', '/web'),
  const DrawerMenuItem(Icons.photo_camera, '福利', '/welfare'),
  const DrawerMenuItem(Icons.video_library, '休息视频', '/video'),
  const DrawerMenuItem(Icons.book, '闲读', '/book')
];
