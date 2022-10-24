class Publishing {
  final String pub_id;
  final String book_num;
  final String sequential_deposit_no;
  final String owner;
  final String name;
  final String establishment_date;


  const Publishing({
    required this.pub_id,
    required this.book_num,
    required this.sequential_deposit_no,
    required this.owner,
    required this.establishment_date,
    required this.name,

  });

  factory Publishing.fromJson(Map<String, dynamic> json) => Publishing(

    pub_id: json['pub_id'],
    book_num: json['book_num'],
    sequential_deposit_no: json['sequential_deposit_no'],
    owner: json['owner'],
    establishment_date: json['establishment_date'],
    name: json['pub_name'],

  );

  Map<String, dynamic> toJson() => {

    'pub_id': pub_id,
    'book_num': book_num,
    'sequential_deposit_no': sequential_deposit_no,
    'owner': owner,
    'establishment_date': establishment_date,
    'pub_name': name,

  };
}
