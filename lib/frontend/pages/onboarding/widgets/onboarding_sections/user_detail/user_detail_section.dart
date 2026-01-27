import 'package:flutter/material.dart';
import '../../../../../../domain/entity/item.dart';
import '../../../../../../domain/entity/gender_enum.dart';
import '../../../../../config/app_spacing.dart';
import '../meal_planning/check_circle_container.dart';

class UserDetailSection extends StatefulWidget {
  final TextEditingController ageController;
  final TextEditingController locationController;
  final void Function(int?) selectedId;

  const UserDetailSection({
    super.key,
    required this.selectedId,
    required this.ageController,
    required this.locationController,
  });

  @override
  State<UserDetailSection> createState() => _UserDetailSectionState();
}

class _UserDetailSectionState extends State<UserDetailSection> {
  void _handleTap(Item item) {
    setState(() {
      selectedItemId = (selectedItemId == item.id) ? null : item.id;
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text(
            'Tell us a little bit about yourself',
            style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          AppSpacing.h24,
          Text('Please select a gender', style: textTheme.titleSmall),
          AppSpacing.h08,
          Row(
            children: items.map((item) {
              final bool isSelected = selectedItemId == item.id;
              widget.selectedId(selectedItemId);
              return Expanded(
                child: CheckCircleContainer(
                  isSelected: isSelected,
                  onTap: _handleTap,
                  item: item,
                ),
              );
            }).toList(),
          ),
          AppSpacing.h16,
          Text('How old are you?', style: textTheme.titleSmall),
          AppSpacing.h08,
          TextFormField(
            controller: widget.ageController,
            keyboardType: TextInputType.number,
          ),
          AppSpacing.h16,
          Text('Where do you live? (country)', style: textTheme.titleSmall),
          AppSpacing.h08,
          TextFormField(
            controller: widget.locationController,
            keyboardType: TextInputType.text,
          ),
        ],
      ),
    );
  }
}
