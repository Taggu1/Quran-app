import 'package:flutter/material.dart';

import '../../../../core/widgets/popup_card/popup_card.dart';

class OptionsTile extends StatelessWidget {
  final String title;
  final String tag;
  final Widget popUpPage;
  final String subTitle;
  const OptionsTile(
      {Key? key,
      required this.title,
      required this.tag,
      required this.popUpPage,
      required this.subTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupItemLauncher(
      padding: 10,
      tag: tag,
      child: Container(
        color: Theme.of(context).backgroundColor,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headline4,
              ),
              Text(
                subTitle,
                style: Theme.of(context).textTheme.headline5,
              ),
            ],
          ),
        ),
      ),
      popUp: PopUpItem(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        color: Theme.of(context).backgroundColor,
        padding: const EdgeInsets.all(8),
        tag: tag,
        child: popUpPage,
      ),
    );
  }
}
