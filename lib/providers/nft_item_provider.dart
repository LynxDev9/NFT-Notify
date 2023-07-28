import 'package:flutter/foundation.dart';
import 'package:nft_notify/data/magic_eden_api.dart';
import 'package:nft_notify/models/nft_item.dart';

class Nfts with ChangeNotifier {
  final List<NftItem?> _items = [
    NftItem(
        id: 'CAghHBZQFu3coeUzhDG8xeucGEMp3o12THh1QSvsUnnF',
        name: "Bohemian #2894",
        imageUrl:
            "https://arweave.net/mXbqaNXf1Yc921nDm3nz0-Oa3RPBNi6w7iKSzlk7qbs?ext=png",
        collection: "bohemia_",
        owner: '68aetbStWLXvf89SRcMHeXTNpSYFbUmeC1QvwgJ2J9Vh',
        isListed: true),
    NftItem(
      id: '9JaoVYoE2ySj4PohvNNKcoCv3X5yZZ7WZFuoSQzo2P73',
      name: "MonkeyKing #3805",
      imageUrl:
          "https://bafybeiarcll3lhgg57z265odwyofrrzylzv7d3v5pfcjuywh4m3225p66u.ipfs.dweb.link/3804.png",
      collection: "chainmyth",
      owner: 'DCS1h4ro9f7YDq6Re1h2EoUz8yPkRifXqg1kyNnxwXZG',
    ),
    NftItem(
        id: '7aWnANs3YAXH4wCXeyzVkwDFdAELriD1imvLGWKb95cn',
        name: "Bohemian #187",
        imageUrl:
            "https://arweave.net/DDwFzjbwyZyrSi_-0NNIljSQdZpNHc0-xbMwJwe6yGg?ext=png",
        collection: "bohemia_",
        owner: 'GWamhsMC8dyP2bSMAz4JVT7gWXDuMGct1KZxGSL1VJ3H',
        isListed: true),
  ];
  List<NftItem?> get itemsNft {
    return _items;
  }

  NftItem? getNftByToken(String? token) {
    if (itemsNft.isEmpty || token == null) {
      return null;
    }
    return itemsNft.singleWhere((element) => element?.id == token,
        orElse: () => null);
  }

  Future<void> getItemNft(String token) async {
    Map<String, dynamic> apiData = await getDataFromApi(token);
    Map<dynamic, dynamic> Stats = await getStatsPriceFromApi(apiData["collection"]);
    print('floorPrice');
    print(Stats);
    _items.add(NftItem(
        id: token,
        name: apiData["name"],
        imageUrl: apiData["image"],
        collection: apiData["collection"],
        owner: apiData["owner"],
        isListed: apiData["collection"] != null));
    notifyListeners();
  }

  makeNftListed(String token) {
    int _index = itemsNft.indexWhere((element) => element?.id == token);
    _items[_index]?.isListed = false;
    notifyListeners();
  }
  makeNftDecreasing(String token) {
    int _index = itemsNft.indexWhere((element) => element?.id == token);
    _items[_index]?.tempAlert = true;
    notifyListeners();
  }
}
