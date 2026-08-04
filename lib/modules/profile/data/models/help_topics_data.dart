import 'help_topic_model.dart';

class HelpTopicsData {
  static const List<HelpTopicModel> seed = [
    HelpTopicModel(
      id: 'about_letsplay',
      title: 'About LetsPlay',
      body:
          'LetsPlay is an interactive Arabic learning platform designed to make language learning fun and engaging.',
      isInitiallyExpanded: true,
    ),
    HelpTopicModel(
      id: 'ted_talk',
      title: 'TED Talk',
      body: 'Watch inspiring TED talks to improve your listening skills and learn from thought leaders.',
      isInitiallyExpanded: false,
    ),
    HelpTopicModel(
      id: 'account',
      title: 'Account',
      body: 'Manage your account settings, profile information, and preferences.',
      isInitiallyExpanded: false,
    ),
    HelpTopicModel(
      id: 'privacy',
      title: 'Privacy',
      body: 'Your privacy is important to us. Learn how we protect and handle your personal data.',
      isInitiallyExpanded: false,
    ),
    HelpTopicModel(
      id: 'technical_problems',
      title: 'Technical Problems',
      body: 'Troubleshooting guide for common technical issues you might encounter.',
      isInitiallyExpanded: false,
    ),
    HelpTopicModel(
      id: 'using_letsplay',
      title: 'Using LetsPlay',
      body: 'Learn how to navigate and use all the features available in the LetsPlay app.',
      isInitiallyExpanded: false,
    ),
  ];
}
