class NewsResponse {
  String? message;
  List<NewsModel> news = [];

  NewsResponse.fromJson(Map<String, dynamic> json) {
    message = json["message"];
    json["data"].forEach((e) {
      news.add(NewsModel.fromJson(e));
    });
  }
}

class NewsModel {
  int? id;
  String? image;
  String? news;

  NewsModel({this.image, this.news, this.id});

  NewsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }
}
