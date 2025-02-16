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
              child: Builder(builder: (context) {
                switch (matchProvider.matchState) {
                  case MatchState.initial:
                    return Center(child: CircularProgressIndicator());
                  case MatchState.loading:
                    return Center(child: CircularProgressIndicator());
                  case MatchState.loaded:
                    return ListView.builder(
                      itemCount: matchProvider.matches.length,
                      itemBuilder: (context, index) {
                        final match = matchProvider.matches[index];
                        return Item(
                          profileModel: match,
                        );
                      },
                    );
                  case MatchState.error:
                    return Center(child: Text('Error'));
                }
              }),
            ),
          ],
        );
      }),
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
        elevation: 2,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: ListTile(
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(profileModel: profileModel),
                ),
              )
            },
            leading: CircleAvatar(
              backgroundImage: NetworkImage(profileModel.profilePictureUrl ??
                  "https://picsum.photos/200"),
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
