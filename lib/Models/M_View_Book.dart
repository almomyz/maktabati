class M_View_Book {
  String? bookId;
  String? title;
  String? num_of_copies;
  String? pub_name;
  String? cat_name;
  String? lang_name;
  String? author_name;
  String? subtitle;
  String? photo;
  String? description;
  String? price;
  String? pagesNo;
  String? depositoryNo;
  String? isbn;
  String? deweyNo;
  String? publicationDate;
  String? editionNo;
  String? format;
  String? size;
  String? targetGroup;
  String? coverDesigner;
  String? storyPainter;
  String? catId;
  String? rating;
  String? authorId;
  String? authorName;
  String? authorDescription;
  String? authorProfession;
  String? authorBirthdate;
  String? authorDeathdate;




  M_View_Book(
      {this.bookId,
        this.title,

        this.pub_name,
        this.author_name,
        this.lang_name,
        this.subtitle,
        this.photo,
        this.description,
        this.price,
        this.pagesNo,
        this.depositoryNo,
        this.isbn,
        this.num_of_copies,
        this.deweyNo,
        this.cat_name,
        this.publicationDate,
        this.editionNo,
        this.format,
        this.size,
        this.targetGroup,
        this.coverDesigner,
        this.storyPainter,
        this.catId,
        this.rating,
        this.authorId,
        this.authorName,
        this.authorDescription,
        this.authorProfession,
        this.authorBirthdate,
        this.authorDeathdate});



  M_View_Book.fromJson(Map<String, dynamic> json) {
    bookId = json['book_id'];
    title = json['title'];
    lang_name = json['lang_name'];
    cat_name = json['cat_name'];
    pub_name = json['pub_name'];
    subtitle = json['subtitle'];
    photo = json['photo'];
    description = json['description'];
    price = json['price'];
    author_name = json['author_name'];
    num_of_copies = json['num_of_copies'];
    pagesNo = json['pages_no'];
    depositoryNo = json['depository_no'];
    isbn = json['isbn'];
    deweyNo = json['dewey_no'];
    publicationDate = json['publication_date'];
    editionNo = json['edition_no'];
    format = json['format'];
    size = json['size'];
    targetGroup = json['target_group'];
    coverDesigner = json['cover_designer'];
    storyPainter = json['story_painter'];
    catId = json['cat_id'];
    rating = json['rating'];
    authorId = json['author_id'];
    authorName = json['author_name'];
    authorDescription = json['author_description'];
    authorProfession = json['author_profession'];
    authorBirthdate = json['author_birthdate'];
    authorDeathdate = json['author_deathdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['book_id'] = this.bookId;
    data['lang_name'] = this.lang_name;
    data['title'] = this.title;
    data['pub_name'] = this.pub_name;
    data['subtitle'] = this.subtitle;
    data['photo'] = this.photo;
    data['description'] = this.description;
    data['price'] = this.price;
    data['cat_name'] = this.cat_name;
    data['author_name'] = this.author_name;
    data['num_of_copies'] = this.num_of_copies;
    data['pages_no'] = this.pagesNo;
    data['depository_no'] = this.depositoryNo;
    data['isbn'] = this.isbn;
    data['dewey_no'] = this.deweyNo;
    data['publication_date'] = this.publicationDate;
    data['edition_no'] = this.editionNo;
    data['format'] = this.format;
    data['size'] = this.size;
    data['target_group'] = this.targetGroup;
    data['cover_designer'] = this.coverDesigner;
    data['story_painter'] = this.storyPainter;
    data['cat_id'] = this.catId;
    data['rating'] = this.rating;
    data['author_id'] = this.authorId;
    data['author_name'] = this.authorName;
    data['author_description'] = this.authorDescription;
    data['author_profession'] = this.authorProfession;
    data['author_birthdate'] = this.authorBirthdate;
    data['author_deathdate'] = this.authorDeathdate;
    return data;
  }




}