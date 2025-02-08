import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MatchProfilePage extends StatefulWidget {
  @override
  _MatchProfilePageState createState() => _MatchProfilePageState();
}

class _MatchProfilePageState extends State<MatchProfilePage> {
  
  final List<Map<String, String>> _items = [
    {
      'profile_photo_url': 'https://irs3.4sqi.net/img/user/original/HBVX4T2WQOGG20FE.png',
      'name': 'John Doe',
      'hometown': 'New York, NY',
      'phone': '123-456-7890',
    },
    {
      'profile_photo_url': 'https://irs3.4sqi.net/img/user/original/HBVX4T2WQOGG20FE.png',
      'name': 'Jane Doe',
      'hometown': 'Los Angeles, CA',
      'phone': '123-456-7890',
    },
    {
      'profile_photo_url': 'https://irs3.4sqi.net/img/user/original/HBVX4T2WQOGG20FE.png',
      'name': 'John Smith',
      'hometown': 'Chicago, IL',
      'phone': '123-456-7890',
    },
    {
      'profile_photo_url': 'https://irs3.4sqi.net/img/user/original/HBVX4T2WQOGG20FE.png',
      'name': 'Jane Smith',
      'hometown': 'Houston, TX',
      'phone': '123-456-7890',
    },
  ];


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _items.length,
      itemBuilder: (context, index) {
        final item = _items[index];
        return Item(
          profile_photo_url: item['profile_photo_url']!,
          name: item['name']!,
          hometown: item['hometown']!,
          phone: item['phone']!,
        );
      },
    );
  }
}


class Item extends StatelessWidget {
  final String profile_photo_url;
  final String name;
  final String hometown;
  final String phone;

  Item({required this.profile_photo_url, required this.name, required this.hometown, required this.phone});

  @override
  Widget build(BuildContext context) {
   final Uri _url = Uri.parse("tel://$phone");
    return Card(child: ListTile(
            onTap: () => {},
            leading: CircleAvatar(
              backgroundImage: NetworkImage(profile_photo_url),
            ),
            title: Text(
              name,
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              hometown,
              style: TextStyle(color: Colors.grey),
              overflow: TextOverflow.ellipsis,
            ),
            trailing: IconButton(onPressed: () => launchUrl(_url), icon: Icon(Icons.phone)),
          ));
  }
}

