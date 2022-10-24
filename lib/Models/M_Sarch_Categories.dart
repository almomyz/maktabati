class Categories {
  final String cat_name;
  final String book_num;
  final String cat_id;

  const Categories({

    required this.book_num,
    required this.cat_name,
    required this.cat_id,
  });

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(

    book_num: json['book_num'],
    cat_name: json['cat_name'],
    cat_id: json['cat_id'],
  );

  Map<String, dynamic> toJson() => {

    'book_num': book_num,
    'cat_name': cat_name,
    'cat_id': cat_id,
  };
}
