class NftItem {
  String? id;
  String? name = '0';
  String? imageUrl;
  String? collection;
  String? owner;
  double? price;
  bool toNotify;
  bool isListed;
  bool tempAlert;
  NftItem({
    this.id,
    this.name,
    this.imageUrl,
    this.collection,
    this.owner,
    this.price,
    this.toNotify = true,
    this.isListed = false,
    this.tempAlert = false,
  });
}
