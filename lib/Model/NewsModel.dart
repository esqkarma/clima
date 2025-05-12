

class NewsModel {
  String? title;
  String? description;
  NewsModel({required this.description,required this.title});

  factory NewsModel.fromJson(Map<String,dynamic> json)
  {
    return NewsModel(description: json['description'], title: json['title']);
  }


}




