import 'package:flutter/material.dart';
import '../../../app_theme.dart';

class InterestsSection extends StatelessWidget {
  final List<String> interests;
  final List<String> languages;

  const InterestsSection({
    Key? key,
    required this.interests,
    required this.languages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filteredInterests =
        interests.where((interest) => interest.isNotEmpty).toList();
    final filteredLanguages =
        languages.where((language) => language.isNotEmpty).toList();

    if (filteredInterests.isEmpty && filteredLanguages.isEmpty) {
      return SizedBox
          .shrink(); // Return an empty widget if no information is available
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Interests & Languages',
          style: Theme.of(context)
              .textTheme
              .displayMedium
              ?.copyWith(color: AppTheme.secondaryColor),
        ),
        const SizedBox(height: 12),
        Card(
          elevation: 2,
          color: AppTheme.lightGray,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (filteredInterests.isNotEmpty)
                  _buildChipSection(context, 'Interests', filteredInterests),
                if (filteredInterests.isNotEmpty &&
                    filteredLanguages.isNotEmpty)
                  const SizedBox(height: 16),
                if (filteredLanguages.isNotEmpty)
                  _buildChipSection(context, 'Languages', filteredLanguages),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChipSection(
      BuildContext context, String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: AppTheme.darkGray),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: items.map((item) => _buildChip(context, item)).toList(),
        ),
      ],
    );
  }

  Widget _buildChip(BuildContext context, String label) {
    return Chip(
      label: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: AppTheme.white),
      ),
      backgroundColor: AppTheme.secondaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 8),
    );
  }
}
