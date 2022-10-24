class M_View_author {
  String? authorId;
  String? authorName;
  String? bookNum;

  M_View_author({this.authorId, this.authorName, this.bookNum});

  M_View_author.fromJson(Map<String, dynamic> json) {
    authorId = json['author_id'];
    authorName = json['author_name'];
    bookNum = json['book_num'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['author_id'] = this.authorId;
    data['author_name'] = this.authorName;
    data['book_num'] = this.bookNum;
    return data;
  }
}