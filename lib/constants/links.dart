class UniversityLinks {
  static const String officialWebsite = 'https://bugemauniv.ac.ug/';
  static const String studentPortal = 'https://erms.bugemauniv.ac.ug/student/login/';
  static const String staffPortal = 'https://erms.bugemauniv.ac.ug/staff/login/';
  static const String elearning = 'https://elearning.bugemauniv.ac.ug/';
  static const String payments = 'https://payments.bugemauniv.ac.ug/payments/';
  static const String paymentStatus = 'https://payments.bugemauniv.ac.ug/payments/status/';
  static const String library = 'http://lib.bugemauniv.ac.ug';
  static const String libraryCatalog = 'https://koha.bugemauniv.ac.ug';
  static const String repository = 'https://buir.bugemauniv.ac.ug/xmlui/';
  static const String journals = 'https://journal.bugemauniv.ac.ug/';
}

class LinkItem {
  final String title;
  final String url;
  final String description;
  final String category;
  final String iconEmoji;

  const LinkItem({
    required this.title,
    required this.url,
    required this.description,
    required this.category,
    required this.iconEmoji,
  });
}

const List<LinkItem> allUniversityLinks = [
  LinkItem(
    title: 'Official Website',
    url: UniversityLinks.officialWebsite,
    description: 'Explore programs, admissions, and general university news.',
    category: 'Primary',
    iconEmoji: '🏫',
  ),
  LinkItem(
    title: 'Student Portal (ERMS)',
    url: UniversityLinks.studentPortal,
    description: 'Register for classes, check grades, and view invoices.',
    category: 'Academic',
    iconEmoji: '🎓',
  ),
  LinkItem(
    title: 'Staff Portal (ERMS)',
    url: UniversityLinks.staffPortal,
    description: 'Manage teaching schedules, submit grades, and view reports.',
    category: 'Staff Portal',
    iconEmoji: '👨‍🏫',
  ),
  LinkItem(
    title: 'E-Learning (ODeL)',
    url: UniversityLinks.elearning,
    description: 'Access virtual classes, assignments, and online exams.',
    category: 'Learning',
    iconEmoji: '📚',
  ),
  LinkItem(
    title: 'Online Payments',
    url: UniversityLinks.payments,
    description: 'Pay tuition, registration, and other university fees online.',
    category: 'Finance',
    iconEmoji: '💳',
  ),
  LinkItem(
    title: 'Payment Status Tracker',
    url: UniversityLinks.paymentStatus,
    description: 'Track and verify the status of your online transactions.',
    category: 'Finance',
    iconEmoji: '🧾',
  ),
  LinkItem(
    title: 'Main E-Library Portal',
    url: UniversityLinks.library,
    description: 'Access thousands of electronic books, journals, and databases.',
    category: 'Library',
    iconEmoji: '📖',
  ),
  LinkItem(
    title: 'Library Catalog (Koha OPAC)',
    url: UniversityLinks.libraryCatalog,
    description: 'Search and reserve physical books in the campus library.',
    category: 'Library',
    iconEmoji: '🔍',
  ),
  LinkItem(
    title: 'Institutional Repository (BUIR)',
    url: UniversityLinks.repository,
    description: 'Browse academic research papers and dissertations from BU.',
    category: 'Research',
    iconEmoji: '🗄️',
  ),
  LinkItem(
    title: 'Scholarly Journals (OJS)',
    url: UniversityLinks.journals,
    description: 'Read peer-reviewed journals published by Bugema University.',
    category: 'Research',
    iconEmoji: '📰',
  ),
];

