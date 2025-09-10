import 'package:flutter/material.dart';

class LegalInfoPage extends StatelessWidget {
  const LegalInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Legal Information'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Terms & Conditions'),
              Tab(text: 'Privacy Policy'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildLegalTextView(
              title: 'Terms & Conditions',
              lastUpdated: 'October 26, 2023',
              // TODO: Load this content from a remote source or local asset file.
              content: _getTermsContent(),
            ),
            _buildLegalTextView(
              title: 'Privacy Policy',
              lastUpdated: 'October 26, 2023',
              // TODO: Load this content from a remote source or local asset file.
              content: _getPrivacyPolicyContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegalTextView({
    required String title,
    required String lastUpdated,
    required String content,
  }) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('Last updated: $lastUpdated', style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Colors.grey)),
          const SizedBox(height: 24),
          Text(
            content,
            style: const TextStyle(fontSize: 16, height: 1.5),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  String _getTermsContent() {
    return '''
1. Introduction
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam. Sed nisi. Nulla quis sem at nibh elementum imperdiet. Duis sagittis ipsum. Praesent mauris. Fusce nec tellus sed augue semper porta. Mauris massa.

2. User's Responsibility
Vestibulum lacinia arcu eget nulla. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Curabitur sodales ligula in libero. Sed dignissim lacinia nunc. Curabitur tortor. Pellentesque nibh. Aenean quam. In scelerisque sem at dolor. Maecenas mattis.

3. Intellectual Property
Sed convallis magna eu sem. Duis ac turpis. Integer rutrum ante eu lacus. Vestibulum libero nisl, porta vel, scelerisque eget, malesuada at, neque. Vivamus eget nibh. Etiam cursus leo vel metus. Nulla facilisi. Aenean nec eros.

4. Termination
Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Morbi lacinia molestie dui. Praesent blandit dolor. Sed non quam. In vel mi sit amet augue congue elementum. Morbi in ipsum sit amet pede facilisis laoreet. Donec lacus nunc, viverra nec, blandit vel, egestas et, augue.
''';
  }

  String _getPrivacyPolicyContent() {
    return '''
1. Information We Collect
Ut tellus dolor, dapibus eget, elementum vel, cursus eleifend, elit. Aenean auctor wisi et urna. Aliquam erat volutpat. Duis ac turpis. Integer rutrum ante eu lacus. Vestibulum libero nisl, porta vel, scelerisque eget, malesuada at, neque.

2. How We Use Your Information
Vivamus eget nibh. Etiam cursus leo vel metus. Nulla facilisi. Aenean nec eros. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Suspendisse sollicitudin velit sed leo. Ut pharetra augue nec augue.

3. Information Sharing and Disclosure
Nam elit agna, endrerit sit amet, tincidunt ac, viverra sed, nulla. Donec porta diam eu massa. Quisque diam lorem, interdum vitae, dapibus ac, scelerisque vitae, pede. Donec eget tellus non erat lacinia fermentum.

4. Data Security
Donec in velit vel ipsum auctor pulvinar. Vestibulum iaculis lacinia est. Proin dictum elementum velit. Fusce euismod consequat ante. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Pellentesque sed dolor. Aliquam congue fermentum nisl.
''';
  }
}
