import 'package:flutter/material.dart';
import 'package:flutter_gank/ui/book/BookList.dart';

class Book extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabList.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('闲读'),
          bottom: TabBar(
              isScrollable: true,
              tabs: tabList.map((TabContent tab) {
                return Tab(
                  text: tab.title,
                );
              }).toList()),
        ),
        body: TabBarView(
          children: tabList.map((TabContent tab) {
            return BookList(category: tab.id);
          }).toList(),
        ),
      ),
    );
  }
}

class TabContent {
  final String id;
  final String title;

  const TabContent({this.id, this.title});
}

const List<TabContent> tabList = <TabContent>[
  const TabContent(id: 'qdaily', title: '好奇心日报'),
  const TabContent(id: 'zhihu', title: '知乎日报'),
  const TabContent(id: 'vice', title: 'Vice'),
  const TabContent(id: 'ifanr', title: '爱范儿'),
  const TabContent(id: 'engadget', title: 'Engadget'),
  const TabContent(id: 'ipc', title: 'iPc.me'),
  const TabContent(id: 'techcrunch', title: 'TechCrunch'),
  const TabContent(id: 'solidot', title: 'Solidot'),
  const TabContent(id: 'williamlong', title: '月光博客'),
  const TabContent(id: 'toodaylab', title: '理想生活实验室'),
];
