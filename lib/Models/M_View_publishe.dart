class M_View_publishe {
  String? pubId;
  String? name;
  String? bookNum;

  M_View_publishe({this.pubId, this.name, this.bookNum});

  M_View_publishe.fromJson(Map<String, dynamic> json) {
    pubId = json['pub_id'];
    name = json['pub_name'];
    bookNum = json['book_num'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pub_id'] = this.pubId;
    data['pub_name'] = this.name;
    data['book_num'] = this.bookNum;
    return data;
  }
}