class M_View_Categories {
  String? catId;
  String? catName;
  String? bookNum;

  M_View_Categories({this.catId, this.catName, this.bookNum});

  M_View_Categories.fromJson(Map<String, dynamic> json) {
    catId = json['cat_id'];
    catName = json['cat_name'];
    bookNum = json['book_num'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cat_id'] = this.catId;
    data['cat_name'] = this.catName;
    data['book_num'] = this.bookNum;
    return data;
  }
}