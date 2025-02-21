import 'package:flutter/material.dart';
import 'package:kumbh_milap/app_theme.dart';
import 'package:kumbh_milap/core/model/profile_model.dart';
import 'package:kumbh_milap/presentation/providers/like_provider.dart';
import 'package:kumbh_milap/presentation/screens/home/detail_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LikeProfilePage extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LikeProvider()..getMatches(),
      child: Builder(builder: (context) {
        final likeProvider = Provider.of<LikeProvider>(context);
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 20),
              child: Text(
                AppLocalizations.of(context)!.likes,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: Colors.black,
                    ),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await likeProvider.getMatches();
                },
                color: Theme.of(context).scaffoldBackgroundColor,
                backgroundColor: Theme.of(context).primaryColor,
                child: switch (likeProvider.likeState) {
                  LikeState.initial =>
                    _buildLoadingOrError(child: CircularProgressIndicator()),
                  LikeState.loading =>
                    _buildLoadingOrError(child: CircularProgressIndicator()),
                  LikeState.loaded => likeProvider.matches.isEmpty
                      ? _buildEmptyState(context)
                      : GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 1.0,
                          ),
                          itemCount: likeProvider.matches.length,
                          itemBuilder: (context, index) {
                            final match = likeProvider.matches[index];
                            return MatchCard(
                              profileModel: match,
                            );
                          },
                        ),
                  LikeState.error => _buildLoadingOrError(
                      child: Text(AppLocalizations.of(context)!.error))
                },
              ),
            )
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
              'assets/sadhu.png', // Add this image to your assets
              height: 200,
              width: 200,
            ),
            const SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.noLikesFound,
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

class MatchCard extends StatelessWidget {
  final ProfileModel profileModel;

  const MatchCard({super.key, required this.profileModel});

  @override
  Widget build(BuildContext context) {
    final likeProvider = Provider.of<LikeProvider>(context);
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(
                profileModel: profileModel,
                labelPage: 'Likes',
                onPressed:  () async {
                  await likeProvider.matchNow(profileModel.user_id);
                  Navigator.pop(context);
                },
              ),
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
                (profileModel.profilePictureUrl == null ||
                        profileModel.profilePictureUrl!.isEmpty)
                    ? Image.asset(
                        'assets/sadhu.png',
                        width: double.infinity,
                        height: 350,
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        profileModel.profilePictureUrl ?? '',
                        width: double.infinity,
                        height: 350,
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      (loadingProgress.expectedTotalBytes ?? 1)
                                  : null,
                            ),
                          );
                        },
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return Center(
                            child: Icon(
                              Icons.error,
                              color: Colors.red,
                              size: 50,
                            ),
                          );
                        },
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
                // Positioned(
                //   top: 10,
                //   left: 10,
                //   child: Container(
                //     padding:
                //         const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                //     decoration: BoxDecoration(
                //       color: Colors.purple.withOpacity(0.8),
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //     child: Text(
                //       profileModel.subgroup ?? "Brahmin",
                //       style: const TextStyle(
                //         color: Colors.white,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //   ),
                // ),
                // Positioned(
                //   bottom: 50,
                //   left: 10,
                //   child: Container(
                //     padding:
                //         const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                //     decoration: BoxDecoration(
                //       color: Colors.white.withOpacity(0.8),
                //       borderRadius: BorderRadius.circular(20),
                //     ),
                //     child: Text(
                //       profileModel.occupation ?? "Software Engineer",
                //       style: const TextStyle(fontWeight: FontWeight.bold),
                //     ),
                //   ),
                // ),
                Positioned(
                  bottom: 20,
                  left: 8,
                  child: Row(
                    children: [
                      Text(
                        "${profileModel.name?.split(' ')[0] ?? ''}, ${profileModel.age} ",
                        style:
                            Theme.of(context).textTheme.displayMedium?.copyWith(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: 5,
                  left: 10,
                  child: Text(
                    "${profileModel.occupation}",
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
        ));
  }
}
