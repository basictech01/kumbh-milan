import 'package:flutter/material.dart';
import 'package:kumbh_milap/app_theme.dart';

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Image Placeholder
            Stack(
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  color: AppTheme.lightGray, // Placeholder background
                  child: Center(
                    child:
                        Icon(Icons.person, size: 100, color: AppTheme.darkGray),
                  ),
                ),
                Positioned(
                  top: 15,
                  left: 15,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: AppTheme.black),
                    onPressed: () {},
                  ),
                ),
                Positioned(
                  top: 15,
                  right: 15,
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.share, color: AppTheme.black),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.more_vert, color: AppTheme.black),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Name and Distance
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('Frances McKnight',
                          style: Theme.of(context).textTheme.displayMedium),
                      SizedBox(width: 5),
                      Icon(Icons.verified,
                          color: AppTheme.secondaryColor, size: 20),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.location_on,
                          size: 18, color: AppTheme.lightGray),
                      SizedBox(width: 5),
                      Text('2 km away',
                          style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                ],
              ),
            ),

            // Action Buttons
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: Text('High five',
                          style: Theme.of(context).textTheme.labelLarge),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: Text('Say hi',
                          style: Theme.of(context).textTheme.labelLarge),
                    ),
                  ),
                ],
              ),
            ),

            // Fun Fact
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: AppTheme.lightGray,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Something you should know about me is...',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Some text here',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
    );
  }
}