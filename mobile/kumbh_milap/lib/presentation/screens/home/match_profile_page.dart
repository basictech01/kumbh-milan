import 'package:flutter/material.dart';
import 'package:kumbh_milap/core/model/profile_model.dart';
import 'package:kumbh_milap/presentation/providers/match_provider.dart';
import 'package:kumbh_milap/presentation/screens/home/detail_page.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MatchProfilePage extends StatefulWidget {
  @override
  _MatchProfilePageState createState() => _MatchProfilePageState();
}

class _MatchProfilePageState extends State<MatchProfilePage> {
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_) => MatchProvider()..getMatches(), 
      child: Builder(builder: (context) {
        final matchProvider = Provider.of<MatchProvider>(context);
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
    );
  }
}


class Item extends StatelessWidget {
  final ProfileModel profileModel;

  Item({required this.profileModel});

  @override
  Widget build(BuildContext context) {
   final Uri _url = Uri.parse("tel://${profileModel.phone}");
    return Card(child: ListTile(
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                builder: (context) => DetailPage(profileModel: profileModel),
                ),
              )
            },
            leading: CircleAvatar(
              backgroundImage: NetworkImage("https://picsum.photos/200"),
            ),
            title: Text(
              profileModel.name ?? "temporary name",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              profileModel.home ?? "",
              style: TextStyle(color: Colors.grey),
              overflow: TextOverflow.ellipsis,
            ),
            trailing: IconButton(onPressed: () => launchUrl(_url), icon: Icon(Icons.phone)),
          ));
  }
}

