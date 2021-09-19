import 'package:bluestacks_flutter_dev_assignment/modules/home/tournament_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bluestacks_flutter_dev_assignment/config/themes/bloc/bloc.dart';
import 'package:bluestacks_flutter_dev_assignment/config/themes/theme_config.dart';
import 'package:bluestacks_flutter_dev_assignment/modules/home/models/tournaments_model.dart';
import 'package:bluestacks_flutter_dev_assignment/modules/home/bloc/home_bloc.dart';
import 'package:bluestacks_flutter_dev_assignment/modules/home/repository/home_repository.dart';
import 'package:bluestacks_flutter_dev_assignment/utils/ui_utils.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SetAppScreenConfiguration.init(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>.value(
          value: BlocProvider.of<ThemeBloc>(context),
        ),
        BlocProvider<HomeBloc>(
          create: (BuildContext context) => HomeBloc(
            homeRepository: HomeRepositoryImpl(),
          ),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) => Home(themeState: themeState),
      ),
    );
  }
}

class Home extends StatefulWidget {
  final ThemeState themeState;
  const Home({Key? key, required this.themeState}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late bool _hasMore;
  late String _cursor;
  late bool _error;
  late bool _loading;
  final int _defaultTournamentsPerPageCount = 10;
  late List<Tournament> _tournaments;
  final int _nextPageThreshold = 5;

  @override
  void initState() {
    super.initState();
    _hasMore = true;
    _cursor = "";
    _error = false;
    _loading = true;
    _tournaments = [];

    /// Fetch the tournaments
    fetchTournaments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text("FlyingWolf"),
            leading: const Icon(Icons.menu),
            floating: true,
            flexibleSpace: UserDetails(themeState: widget.themeState),
            expandedHeight: 300.0,
          ),
          SliverList(
            // Use a delegate to build items as they're scrolled on screen.
            delegate: SliverChildBuilderDelegate((context, index) {
              return Padding(
                padding: const EdgeInsets.all(AppSpacing.s),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (index == 0) ...[
                      Text(
                        "Recommended for you",
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      const AppSizedBoxSpacing(),
                    ],
                    _displayTournaments(),
                  ],
                ),
              );
            }
                // Builds 1000 ListTiles
                ),
          ),
        ],
      ),
    );
  }

  Widget _displayTournaments() {
    if (_tournaments.isEmpty && _loading) {
      return const Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircularProgressIndicator(),
        ),
      );
    } else if (_error) {
      return Center(
        child: InkWell(
          onTap: () {
            setState(() {
              _loading = true;
              _error = false;
              fetchTournaments();
            });
          },
          child: const Padding(
            padding: const EdgeInsets.all(16),
            child: Text("Error while loading tournaments. Tap to try again!"),
          ),
        ),
      );
    } else {
      return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _tournaments.length + (_hasMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == _tournaments.length - _nextPageThreshold) {
              ///fetchTournaments();
            }

            if (index == _tournaments.length) {
              if (_error) {
                return Center(
                    child: InkWell(
                  onTap: () {
                    setState(() {
                      _loading = true;
                      _error = false;
                      fetchTournaments();
                    });
                  },
                  child: const Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text("Error while loading photos, tap to try agin"),
                  ),
                ));
              } else {
                return const Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            }

            final Tournament _tournament = _tournaments[index];
            return Column(
              children: [
                TournamentCard(
                  themeState: widget.themeState,
                  tournament: _tournament,
                ),
                const AppSizedBoxSpacing(),
              ],
            );
          },
        ),
      );
    }
  }

  Future<void> fetchTournaments() async {
    final response = await BlocProvider.of<HomeBloc>(context)
        .homeRepository
        .fetchTournaments(cursor: _cursor);

    if (response is TournamentsModel) {
      List<Tournament> _tournamentsResponse = response.tournaments;
      setState(() {
        _hasMore =
            _tournamentsResponse.length == _defaultTournamentsPerPageCount;
        _loading = false;
        _cursor = response.cursor;
        _tournaments.addAll(_tournamentsResponse);
      });
    } else {
      setState(() {
        _loading = false;
        _error = true;
      });
    }
  }
}

class UserDetails extends StatelessWidget {
  final ThemeState themeState;
  const UserDetails({Key? key, required this.themeState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          AppSpacing.s, 125.0, AppSpacing.s, AppSpacing.s),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(
                flex: 3,
                child: CircleAvatar(
                  radius: 50.0,
                  backgroundImage: NetworkImage("https://picsum.photos/200"),
                  backgroundColor: Colors.transparent,
                ),
              ),
              Expanded(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Simon Baker",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      const AppSizedBoxSpacing(heightSpacing: 20.0),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          border: Border.all(color: Colors.blue, width: 2.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: RichText(
                            text: TextSpan(
                              text: "2240 ",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w600),
                              children: <TextSpan>[
                                TextSpan(
                                  text: "Elo rating",
                                  style: Theme.of(context).textTheme.bodyText1,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          const AppSizedBoxSpacing(),
          UserStatistics(themeState: themeState),
        ],
      ),
    );
  }
}

class UserStatistics extends StatelessWidget {
  final ThemeState themeState;
  const UserStatistics({Key? key, required this.themeState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      child: Row(
        children: [
          _displayTournamentPlayedStats(context),
          _displayTournamentLossStats(context),
          _displayWinningPercentageStats(context)
        ],
      ),
    );
  }

  Widget _displayTournamentPlayedStats(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            bottomLeft: Radius.circular(20.0),
          ),
          gradient: LinearGradient(
            colors: [
              Colors.orange,
              Colors.orange.shade400,
              Colors.orange.shade300
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: const StatsContent(count: "20", text: "Tournament Played"),
      ),
    );
  }

  Widget _displayTournamentLossStats(context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.purple,
              Colors.purple.shade400,
              Colors.purple.shade300
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: const StatsContent(count: "10", text: "Tournament Won"),
      ),
    );
  }

  Widget _displayWinningPercentageStats(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
          gradient: LinearGradient(
            colors: [Colors.red, Colors.red.shade400, Colors.red.shade300],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: const StatsContent(count: "50%", text: "Winning Percentage"),
      ),
    );
  }
}

class StatsContent extends StatelessWidget {
  final String count;
  final String text;

  const StatsContent({Key? key, required this.count, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "$count",
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(fontWeight: FontWeight.w600, color: Colors.white),
          ),
          Text(
            "$text",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(color: Colors.white),
          )
        ],
      ),
    );
  }
}
