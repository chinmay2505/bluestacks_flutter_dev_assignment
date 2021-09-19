import 'package:bluestacks_flutter_dev_assignment/config/themes/theme_config.dart';
import 'package:bluestacks_flutter_dev_assignment/utils/ui_utils.dart';
import 'package:flutter/material.dart';

import 'package:bluestacks_flutter_dev_assignment/config/themes/bloc/bloc.dart';
import 'package:bluestacks_flutter_dev_assignment/modules/home/models/tournaments_model.dart';

class TournamentCard extends StatelessWidget {
  final ThemeState themeState;
  final Tournament tournament;

  const TournamentCard(
      {Key? key, required this.themeState, required this.tournament})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppScreenConfig.screenWidth! * 0.9,
      height: 180.0,
      child: Card(
        elevation: 15.0,
        shape: const RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(25.0),
          ),
        ),
        child: Stack(
          children: <Widget>[
            if (tournament.coverUrl?.isNotEmpty ?? false)
              ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: Image.network(
                  tournament.coverUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              )
            else
              const Placeholder(),
            Positioned(
              top: 100.0,
              left: -1.0,
              child: Container(
                width: AppScreenConfig.screenWidth! * 0.9,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardTheme.color,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(25.0),
                    bottomRight: Radius.circular(25.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 150.0,
                            child: Text(
                              tournament.name ?? "",
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                          const AppSizedBoxSpacing(heightSpacing: 5.0),
                          Container(
                            width: 150.0,
                            child: Text(
                              tournament.gameName ?? "",
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: Theme.of(context).textTheme.caption,
                            ),
                          )
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color:
                            (themeState.themeData['primaryTextColor'] as Color)
                                .withOpacity(0.7),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
