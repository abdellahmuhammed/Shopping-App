// ignore_for_file: deprecated_member_use, file_names

class GetFavoritesModel
{
  bool status;
  Data data;

  GetFavoritesModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }
}

class Data {
  int currentPage;
  List<FavoritesData> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  String path;
  int perPage;
  int to;
  int total;

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data =  List<FavoritesData>();
      json['data'].forEach((v) {
        data.add( FavoritesData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }
}

class FavoritesData {
  int id;
  Product product;

  FavoritesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
    json['product'] != null ?  Product.fromJson(json['product']) : null;
  }
}

class Product {
  int id;
  dynamic price;
  dynamic oldPrice;
  int discount;
  int phone;
  String image;
  String name;
  String description;
  String email;

  Product(
      {this.id,
        this.price,
        this.oldPrice,
        this.discount,
        this.image,
        this.name,
        this.phone,
        this.email,
        this.description});

  Product.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    phone = json['phone'];
    email = json['email'];
  }
}