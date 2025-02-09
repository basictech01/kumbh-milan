import 'package:flutter/material.dart';
import 'package:kumbh_milap/presentation/providers/match_provider.dart';
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
                  profile_photo_url: match.profilePictureUrl,
                  name: match.name,
                  hometown: match.home,
                  phone: match.phone,
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
  final String? profile_photo_url;
  final String? name;
  final String? hometown;
  final String? phone;

  Item({this.profile_photo_url, this.name, this.hometown, this.phone});

  @override
  Widget build(BuildContext context) {
   final Uri _url = Uri.parse("tel://$phone");
    return Card(child: ListTile(
            onTap: () => {},
            leading: CircleAvatar(
              backgroundImage: NetworkImage("https://picsum.photos/200"),
            ),
            title: Text(
              name ?? "temporary name",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              hometown ?? "",
              style: TextStyle(color: Colors.grey),
              overflow: TextOverflow.ellipsis,
            ),
            trailing: IconButton(onPressed: () => launchUrl(_url), icon: Icon(Icons.phone)),
          ));
  }
}

