import 'package:flutter/material.dart';
import 'package:nft_notify/models/nft_item.dart';
import 'package:nft_notify/providers/nft_item_provider.dart';
import 'package:nft_notify/widgets/constant.dart';
import 'package:nft_notify/widgets/golbal_widgets.dart';
import 'package:provider/provider.dart';

class FollowedNftScreen extends StatefulWidget {
  const FollowedNftScreen({Key? key}) : super(key: key);

  @override
  State<FollowedNftScreen> createState() => _FollowedNftScreenState();
}

class _FollowedNftScreenState extends State<FollowedNftScreen> {
  List<NftItem?> nfts = [];
  Future<dynamic> _onNotificationClicked() async {
    return showDialog(context: context, builder: (context) => Text(''));
  }



  @override
  void initState() {
    super.initState();
    nfts = Provider.of<Nfts>(context, listen: false).itemsNft;
  }



  _makeItListed(BuildContext context) async {
    //await _showNotification();
    Provider.of<Nfts>(context, listen: false)
        .makeNftListed("EUJNV4s6gx6redioESEzLDx3TTvjLiz67KSkUFESp19X");
    // NotificationApi.showNotification(
    //     title: 'Titre', body: 'Body', payload: 'DGDGFG');
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      nfts = Provider.of<Nfts>(context).itemsNft;
    });
    return Scaffold(
      appBar: AppBar(title: const Text('Followed NFT')),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            const TopContainer(title: 'NFT Item', tealing: 'Notification'),
            nfts.isNotEmpty
                ? ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (ctx, i) {
                      return Column(
                        children: [
                          ListTile(
                            leading: Container(
                              constraints: const BoxConstraints(
                                  maxWidth: 50, maxHeight: 50),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.network(nfts[i]!.imageUrl!),
                              ),
                            ),
                            title: Text(nfts[i]!.name!),
                            subtitle: Text(nfts[i]!.owner!),
                            trailing: (nfts[i]!.isListed && i !=3)
                                ? const Text('Already Listed')
                                : Checkbox(
                                    activeColor: ksecondaryColor,
                                    value: true,
                                    onChanged: (val) {}),
                          )
                        ],
                      );
                    },
                    itemCount: nfts.length,
                  )
                : const Text('You dont Follow any NFT'),
            // ElevatedButton(
            //     onPressed: () => _makeItListed(context), child: Text('Lite'))
          ],
        ),
      ),
    );
  }
}
