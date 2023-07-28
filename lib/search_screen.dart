import 'package:flutter/material.dart';
import 'package:nft_notify/models/nft_item.dart';
import 'package:nft_notify/nft_details.dart';
import 'package:nft_notify/providers/nft_item_provider.dart';
import 'package:nft_notify/widgets/constant.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  NftItem? res;
  String? lovValue;
  String? _token;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nftTokenController = TextEditingController();
  Future<void> _searchToken(String token) async {
    if (token != "") {
      setState(() {
        _token = token;
      });
      await Provider.of<Nfts>(context, listen: false).getItemNft(token);
    }
  }

  @override
  Widget build(BuildContext context) {
    print('_token');
    print(_token);
    res = Provider.of<Nfts>(context).getNftByToken(_token);

    return Scaffold(
      appBar: AppBar(
        title: const Text('NFT Notify'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 8,
                        child:Form(
                    key: _formKey,
                    child:  TextFormField(
                            controller: _nftTokenController,
                            decoration:
                                const InputDecoration(labelText: 'NFT Token'))),
                  ),
                  Expanded(
                    flex: 1,
                    child:Container()
                  ),
                  Expanded(
                    flex: 4,
                    child: DropdownButton(
                      value: lovValue,
                     
                      //isDense: true,
                      isExpanded: true,
                      items: <String>[
                        'Magic Eden',
                        'SolanArt',
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,style: TextStyle(color: Colors.pink.shade800),),
                        );
                      }).toList(),
                      onChanged: (selected) {
                        setState(() {
                          lovValue = selected.toString();
                        });
                      },
                      itemHeight: 75,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: IconButton(
                        onPressed: () => _searchToken(_nftTokenController.text),
                        iconSize: 20,
                        icon: const Icon(
                          Icons.search,
                          color: ksecondaryColor,
                        )),
                  )
                ],
              ),
              if (res != null) NftDetails(res: res!),
            ],
          ),
        ),
      ),
    );
  }
}
