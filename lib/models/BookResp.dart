class BookResp {
  final bool error;
  final List<BookContent> results;

  BookResp(this.error, this.results);

  BookResp.fromJson(Map<String, dynamic> json)
      : error = json['error'],
        results = formatedResults(json['results']);

  static formatedResults(list) {
    List<BookContent> mList = <BookContent>[];
    if (list != null) {
      list.forEach((v) {
        mList.add(BookContent.fromJson(v));
      });
    }
    return mList;
  }
}

class BookContent {
  final String _id;
  final String content;
  final String cover;
  final int crawled;
  final String created_at;
  final bool deleted;
  final String published_at;
  final String raw;
  final Site site;
  final String title;
  final String uid;
  final String url;

  BookContent(
      this._id,
      this.content,
      this.cover,
      this.crawled,
      this.created_at,
      this.deleted,
      this.published_at,
      this.raw,
      this.site,
      this.title,
      this.uid,
      this.url);

  BookContent.fromJson(Map<String, dynamic> json)
      : _id = json['_id'],
        content = json['content'],
        cover = json['cover'],
        crawled = json['crawled'],
        created_at = json['created_at'],
        deleted = json['deleted'],
        published_at = json['published_at'],
        raw = json['raw'],
        site = Site.fromJson(json['site']),
        title = json['title'],
        uid = json['uid'],
        url = json['url'];

  Map<String, dynamic> toJson() => {
        '_id': _id,
        'content': content,
        'cover': cover,
        'crawled': crawled,
        'created_at': created_at,
        'deleted': deleted,
        'published_at': published_at,
        'raw': raw,
        'site': site,
        'title': title,
        'uid': uid,
        'url': url
      };
}

class Site {
  final String cat_cn;
  final String cat_en;
  final String desc;
  final String feed_id;
  final String icon;
  final String id;
  final String name;
  final int subscribers;
  final String type;
  final String url;

  Site(this.cat_cn, this.cat_en, this.desc, this.feed_id, this.icon, this.id,
      this.name, this.subscribers, this.type, this.url);

  Site.fromJson(Map<String, dynamic> json)
      : cat_cn = json['cat_cn'],
        cat_en = json['cat_en'],
        desc = json['desc'],
        feed_id = json['feed_id'],
        icon = json['icon'],
        id = json['id'],
        name = json['name'],
        subscribers = json['subscribers'],
        type = json['type'],
        url = json['url'];

  Map<String, dynamic> toJson() => {
        'cat_cn': cat_cn,
        'cat_en': cat_en,
        'desc': desc,
        'feed_id': feed_id,
        'icon': icon,
        'id': id,
        'name': name,
        'subscribers': subscribers,
        'type': type,
        'url': url
      };
}
