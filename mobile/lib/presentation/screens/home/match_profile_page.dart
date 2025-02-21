import 'package:flutter/material.dart';
import 'package:kumbh_milap/app_theme.dart';
import 'package:kumbh_milap/core/model/profile_model.dart';
import 'package:kumbh_milap/presentation/providers/match_provider.dart';
import 'package:kumbh_milap/presentation/screens/home/detail_page.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MatchProfilePage extends StatefulWidget {
  @override
  _MatchProfilePageState createState() => _MatchProfilePageState();
}

class _MatchProfilePageState extends State<MatchProfilePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MatchProvider()..getMatches(),
      child: Builder(builder: (context) {
        final matchProvider = Provider.of<MatchProvider>(context);
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 20),
              child: Text(
                AppLocalizations.of(context)!.match,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: Colors.black,
                    ),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await matchProvider.getMatches();
                },
                backgroundColor: AppTheme.primaryColor,
                color: AppTheme.white,
                child: Builder(builder: (context) {
                  return switch (matchProvider.matchState) {
                    MatchState.initial =>
                      _buildLoadingOrError(child: CircularProgressIndicator()),
                    MatchState.loading =>
                      _buildLoadingOrError(child: CircularProgressIndicator()),
                    MatchState.loaded => matchProvider.matches.isEmpty
                        ? _buildEmptyState(context)
                        : ListView.builder(
                            itemCount: matchProvider.matches.length,
                            itemBuilder: (context, index) {
                              final match = matchProvider.matches[index];
                              return Item(
                                profileModel: match,
                              );
                            },
                          ),
                    MatchState.error => _buildLoadingOrError(
                        child: Text(AppLocalizations.of(context)!.error))
                  };
                }),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/sadhu.png',
              height: 200,
              width: 200,
            ),
            const SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.noMatchesFound,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.pullToRefresh,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingOrError({required Widget child}) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Container(
        height: 500, // Arbitrary height to ensure scrollability
        child: Center(child: child),
      ),
    );
  }
}

class Item extends StatelessWidget {
  final ProfileModel profileModel;

  Item({required this.profileModel});

  @override
  Widget build(BuildContext context) {
    final Uri _url = Uri.parse("tel://${profileModel.phone}");
    return Card(
        elevation: 0,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: ListTile(
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(
                    profileModel: profileModel,
                    labelPage: 'Match',
                    onPressed: () => launchUrl(_url),
                  ),
                ),
              )
            },
            leading: CircleAvatar(
              backgroundColor: AppTheme.lightGray,
              radius: 28,
              backgroundImage: profileModel.profilePictureUrl != null
                  ? NetworkImage(profileModel.profilePictureUrl ??
                      "https://picsum.photos/200")
                  : AssetImage("assets/sadhu.png"),
            ),
            title: Text(
              profileModel.name ?? "Unknown",
              style: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(color: AppTheme.black, fontSize: 18),
            ),
            subtitle: Text(
              profileModel.home ?? "",
              style: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(color: AppTheme.black, fontSize: 14),
              overflow: TextOverflow.ellipsis,
            ),
            trailing: IconButton(
                onPressed: () => launchUrl(_url),
                icon: Icon(
                  Icons.phone,
                  color: Theme.of(context).primaryColor,
                )),
          ),
        ));
  }
}
