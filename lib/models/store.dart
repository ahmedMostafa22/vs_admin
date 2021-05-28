class Store {
  final String name, id, ownerId;
  String address, category, phoneNum, website;
  final int productsCount;
  int index, level;

  Store(
      {this.name,
      this.id,
      this.ownerId,
      this.address,
      this.category,
      this.phoneNum,
      this.website,
      this.productsCount,
      this.index,
      this.level});


  Store.fromJson(Map<String, dynamic> json) :
        name= json['name'],
        id= json['id'],
        ownerId= json['ownerId'],
        address= json['address'],
        category= json['category'],
        phoneNum= json['phoneNum'],
        website= json['website'],
        productsCount= json['productsCount'],
        index= json['index'],
        level= json['level'];
}
