import 'package:flutter/material.dart';

import '../models/hops_model.dart';

class BulletListForHops extends StatelessWidget {
  final List<HopsModel> hopsList;

  const BulletListForHops({Key? key, required this.hopsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: hopsList.map(
        (hops) {
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
                  '${hops.name} (${hops.attribute})',
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
