import 'package:flutter/material.dart';
import 'package:nft_notify/followed_nft_screen.dart';
import 'package:nft_notify/models/nft_item.dart';
import 'package:nft_notify/widgets/constant.dart';
import 'package:nft_notify/widgets/golbal_widgets.dart';

class NftDetails extends StatefulWidget {
  const NftDetails({
    Key? key,
    required this.res,
  }) : super(key: key);

  final NftItem res;

  @override
  State<NftDetails> createState() => _NftDetailsState();
}

class _NftDetailsState extends State<NftDetails> {
  bool? _checkBoxVal = true;
  bool _isFollowing = false;
  _toggleFollow() {
    setState(() {
      _isFollowing = !_isFollowing;
    });
  }

  _follow(BuildContext context) {
    _toggleFollow();
    // Navigator.of(context).push(
    //     MaterialPageRoute(builder: (context) => const FollowedNftScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        buildTitle('NFT Item'),
        const Divider(),
        buildDeails('Name : ', widget.res.name),
        // buildDeails('Owner : ', widget.res.owner),
        const Divider(),
        Container(
          constraints: BoxConstraints(
              // maxHeight: dynamicWidth(context) / 1.3,
              maxWidth: dynamicWidth(context) / 1.4),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(widget.res.imageUrl ?? '')),
        ),
        const Divider(),
        widget.res.isListed
            ? buildTitleSuccess('Nft is Verified')
            : buildTitleDanger('Not Verified'),
        if (widget.res.isListed)
          const SizedBox(
            height: 8,
          ),
        !widget.res.tempAlert
            ? buildDeails('Floor price : ', '0.35 SOL')
            : buildDeailsfp('FP : ', '0.19 SOL', '0,16'),
        const SizedBox(
          height: 8,
        ),
        if (widget.res.collection == null)
          buildDeails('Collection : ', widget.res.collection!),
        // if (!widget.res.isListed)
        //   Row(
        //     mainAxisAlignment: MainAxisAlignment.end,
        //     children: [
        //       const Text('Get Notified'),
        //       Checkbox(
        //           activeColor: ksecondaryColor,
        //           value: _checkBoxVal,
        //           onChanged: (val) {
        //             setState(() {
        //               _checkBoxVal = val;
        //             });
        //           }),
        //     ],
        //   ),
        ElevatedButton(
            onPressed: () => _follow(context),
            child: Text(
              _isFollowing ? 'FP Notify  ON' : 'FP Notify',
              style: TextStyle(color: _isFollowing ? Colors.black : null),
            ),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    _isFollowing ? Colors.grey[300] : ksecondaryColor)))
      ],
    );
  }

  Text buildTitle(String title) => Text(
        title,
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.blueAccent),
      );
  Widget buildTitleDanger(String title) => Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        decoration:
            BoxDecoration(border: Border.all(color: Colors.red, width: 3)),
        child: Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red),
        ),
      );
  Widget buildTitleSuccess(String title) => Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        decoration:
            BoxDecoration(border: Border.all(color: Colors.green, width: 3)),
        child: Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.green),
        ),
      );

  Row buildDeails(String title, String? value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Expanded(
          child: Text(
            value ?? '',
            softWrap: true,
            style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 18),
          ),
        ),
      ],
    );
  }

  Row buildDeailsfp(String title, String? value, String decVal) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const Icon(
          //Icons.arrow_circle_down,
          Icons.keyboard_double_arrow_down,
          color: Colors.red,
        ),
        Expanded(
          child: Row(
            children: [
              Text(
                value ?? '',
                softWrap: true,
                style:
                    const TextStyle(fontStyle: FontStyle.italic, fontSize: 18),
              ),
              Text(
                ' -' + decVal+' (-45%)',
                style: const TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 18,
                    color: Colors.red),
              )
            ],
          ),
        ),
      ],
    );
  }
}
