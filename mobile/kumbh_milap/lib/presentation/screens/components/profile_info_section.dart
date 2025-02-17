import 'package:flutter/material.dart';
import '../../../app_theme.dart';

class InfoSection extends StatelessWidget {
  final String? title;
  final Map<String, String?> information;

  const InfoSection({
    Key? key,
    this.title,
    required this.information,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filteredInformation = information.entries
        .where((entry) => entry.value != null && entry.value!.isNotEmpty)
        .toList();

    if (filteredInformation.isEmpty) {
      return SizedBox
          .shrink(); // Return an empty widget if no information is available
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null && title!.isNotEmpty)
                Text(title!,
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(color: AppTheme.black, fontSize: 20)),
              const SizedBox(height: 10),
              ...filteredInformation
                  .map((entry) =>
                      _buildInfoRow(context, entry.key, entry.value!))
                  .toList(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8), // Added spacing between cards
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: AppTheme.white,
        shadowColor: Theme.of(context).secondaryHeaderColor,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Expanded(
                  flex: 2,
                  child: Text(
                    label,
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          color: AppTheme.primaryColor,
                          fontSize: 18,
                        ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      value,
                      style:
                          Theme.of(context).textTheme.displayMedium?.copyWith(
                                color: AppTheme.black,
                                fontSize: 16,
                              ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
