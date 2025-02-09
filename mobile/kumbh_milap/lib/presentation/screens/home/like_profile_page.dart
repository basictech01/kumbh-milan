import 'package:flutter/material.dart';
import 'package:kumbh_milap/core/model/profile_model.dart';
import 'package:kumbh_milap/presentation/providers/like_provider.dart';
import 'package:kumbh_milap/presentation/screens/home/detail_page.dart';
import 'package:provider/provider.dart';

class LikeProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LikeProvider()..getMatches(), 
      child: Builder(builder: (context) {
        final likeProvider = Provider.of<LikeProvider>(context);
        switch (likeProvider.likeState) {
          case LikeState.initial:
            return Center(child: CircularProgressIndicator());
          case LikeState.loading:
            return Center(child: CircularProgressIndicator());
          case LikeState.loaded:
            return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 2 columns
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1.0, // Adjust item size ratio
                    ),
                    itemCount: likeProvider.matches.length,
                    itemBuilder: (context, index) {
                    final match = likeProvider.matches[index];
                    return MatchCard(
                      profileModel: match,
                    );
              },
            );
          case LikeState.error:
            return Center(child: Text('Error'));
        }
      }),
    );
  }
}



class MatchCard extends StatelessWidget {
  final ProfileModel  profileModel;

  const MatchCard({
    super.key,
    required this.profileModel
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
        builder: (context) => DetailPage(profileModel: profileModel),
        ),
      );
      },
      child: Container(
      width: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Image.network(
              profileModel.profilePictureUrl ?? "https://fastly.picsum.photos/id/1075/200/200.jpg?hmac=a9PcCsXBonPZ7LCLyWX6dHM1XGbcojML0qhnq-Ee4a4",
              width: double.infinity,
              height: 350,
              fit: BoxFit.cover,
            ),
            Container(
              height: 350,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.1),
                    Colors.black.withOpacity(0.6),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.purple.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  profileModel.subgroup ?? "Brahmin",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 50,
              left: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  profileModel.occupation ?? "Software Engineer",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 10,
              child: Row(
                children: [
                  Text(
                    profileModel.name ?? "SHIV",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 5,
              left: 10,
              child: Text(
                "${profileModel.home}, ${profileModel.age} ",
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    )
    );
  }
}