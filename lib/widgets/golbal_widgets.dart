import 'package:flutter/material.dart';

double dynamicHeightG(context) {
  return (MediaQuery.of(context).size.height -
      // myAppBarG(context).preferredSize.height -
      MediaQuery.of(context).padding.top);
}

double dynamicWidth(context) {
  double result = 0;
  double contextwidth = MediaQuery.of(context).size.width;
  result = contextwidth - 30;
  return result;
}

TextStyle simpleTextStyleGray() {
  return const TextStyle(color: Colors.black54, fontSize: 14);
}

class TopContainer extends StatelessWidget {
  const TopContainer({
    Key? key,
    required this.title,
    required this.tealing,
  }) : super(key: key);
  final String title;
  final String tealing;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColorLight,
      padding: const EdgeInsets.only(left: 20, right: 15, top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: simpleTextStyleGray(),
          ),
          Text(
            tealing,
            style: simpleTextStyleGray(),
          )
        ],
      ),
    );
  }
}
