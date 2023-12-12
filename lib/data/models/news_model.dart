class NewsModel {
  String? image;
  String? news;

  NewsModel({this.image, this.news});

  NewsModel.fromJson(Map<String, dynamic> json) {}
}
