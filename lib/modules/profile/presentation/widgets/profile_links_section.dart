import '../../../../core/utils/app_imports.dart';
import 'profile_link_row.dart';
import 'section_heading.dart';

class ProfileLinksSection extends StatelessWidget {
  const ProfileLinksSection({
    super.key,
    required this.title,
    required this.links,
    this.onLinkTap,
  });

  final String title;
  final List<ProfileLink> links;
  final Function(ProfileLink)? onLinkTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeading(title: title),
        ...links.map(
          (link) => ProfileLinkRow(
            kind: link.kind,
            label: link.label,
            iconAsset: link.iconAsset,
            isImplemented: link.isImplemented,
            onTap: link.isImplemented ? () => onLinkTap?.call(link) : null,
          ),
        ),
      ],
    );
  }
}
