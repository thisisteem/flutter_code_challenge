import 'package:flutter/material.dart';

import '../models/malt_model.dart';

class BulletListForMalt extends StatelessWidget {
  final List<MaltModel> maltList;

  const BulletListForMalt({Key? key, required this.maltList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: maltList.map(
        (malt) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: 12,
              ),
              Text(
                '\u2022',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.black54),
              ),
              const SizedBox(
                width: 6,
              ),
              Expanded(
                child: Text(
                  malt.name,
                  textAlign: TextAlign.left,
                  softWrap: true,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.black54),
                ),
              ),
            ],
          );
        },
      ).toList(),
    );
  }
}
