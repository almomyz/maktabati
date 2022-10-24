class Book {
  final String id;
  final String edition_no;
  final String price;
  final String publication_date;
  final String isbn;
  final String dewey_no;
  final String depository_no;
  final String rating;
  final String title;
  final String author;
  final String pages_no;
  final String urlImage;
  final String format;
  final String story_painter;
  final String subtitle;
  final String size;
  final String description;
  final String lang_name;
  final String pub_name;
  final String cat_name;
  final String part_path;

  const Book({
    required this.subtitle,
    required this.part_path,
    required this.rating,
    required this.cat_name,
    required this.pub_name,
    required this.size,
    required this.format,
    required this.lang_name,

    required this.edition_no,
    required this.dewey_no,

    required this.publication_date,
    required this.isbn,
    required this.depository_no,
    required this.pages_no,
    required this.price,
    required this.description,
    required this.id,
    required this.story_painter,
    required this.author,
    required this.title,
    required this.urlImage,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        id: json['book_id'],
    lang_name: json['lang_name'],
    part_path: json['part_path'],
    pub_name: json['pub_name'],

      format: json['format'],
    cat_name: json['cat_name'],
      rating: json['rating'],
      size: json['size'],

      publication_date: json['publication_date'],
      dewey_no: json['dewey_no'],
      isbn: json['isbn'],
      edition_no: json['edition_no'],
      depository_no: json['depository_no'],
      pages_no: json['pages_no'],
      price: json['price'],
      description: json['description'],
        author: json['author_name'],
        title: json['title'],

        urlImage: json['photo'],
      subtitle:json['subtitle'], story_painter: '',
  );

  Map<String, dynamic> toJson() => {
        'book_id': id,
        'pub_name': pub_name,
        'publication_date': publication_date,
        'cat_name': cat_name,
        'dewey_no': dewey_no,
        'size': size,
        'lang_name': lang_name,
        'isbn': isbn,
        'pages_no': pages_no,
        'rating': rating,
        'depository_no': depository_no,
        'story_painter': story_painter,
        'price': price,
        'description': description,
        'title': title,
        'part_path': part_path,
        'author_name': author,
        'photo': urlImage,
        'subtitle':subtitle
      };
}
