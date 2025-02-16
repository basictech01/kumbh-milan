import 'package:flutter/material.dart';
import 'package:kumbh_milap/app_theme.dart';
import 'package:kumbh_milap/presentation/screens/components/location_badge.dart';

class ProfileInfo extends StatelessWidget {
  final String? name;
  final int? age;
  final String? gender;
  final String? occupation;
  final String? education;
  final String? location;
  final String? subGroup;

  const ProfileInfo({
    Key? key,
    this.name,
    this.age,
    this.gender,
    this.occupation,
    this.education,
    this.location,
    this.subGroup,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${name ?? 'Unknown'}, ${age ?? ' '}",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(color: AppTheme.black),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      education ?? '',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      occupation ?? '',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (subGroup != null && subGroup!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: _buildChip(context, subGroup!),
                    ),
                  if (gender != null && gender!.isNotEmpty)
                    _buildChip(context, gender!),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width * 0.91,
            color: AppTheme.lightGray,
          ),
        ],
      ),
    );
  }

  Widget _buildChip(BuildContext context, String label) {
    return Chip(
      label: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .displayMedium
            ?.copyWith(fontSize: 14, color: AppTheme.black),
      ),
      backgroundColor: AppTheme.white,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      side: BorderSide(color: Theme.of(context).primaryColor), // Added border
    );
  }
}
