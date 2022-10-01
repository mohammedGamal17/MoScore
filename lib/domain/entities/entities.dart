class OnBoardModel {
  String title;
  String subTitle;
  String image;

  OnBoardModel(this.title, this.subTitle, this.image);
}

class Countries {
  int results;
  List<Response> response;

  Countries(this.results, this.response);
}

class Response {
  String name;
  String code;
  String flag;

  Response(this.name, this.code, this.flag);
}
