import 'package:chunmoxiachu_site/core/content.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('every service has a matching detail page', () {
    expect(SiteContent.services, hasLength(3));
    for (final service in SiteContent.services) {
      expect(
        SiteContent.serviceDetails.containsKey(service.slug),
        isTrue,
        reason: 'missing detail copy for ${service.slug}',
      );
    }
  });

  test('every library entry resolves to a collection route', () {
    for (final item in SiteContent.library) {
      expect(
        SiteContent.libraryPages.containsKey(item.path),
        isTrue,
        reason: 'missing collection copy for ${item.path}',
      );
    }
  });

  test('copy is filled in for both languages', () {
    const strings = [
      SiteContent.pageTitle,
      SiteContent.heroHeadline,
      SiteContent.aboutTitle,
      SiteContent.contactTitle,
      SiteContent.notFoundTitle,
      SiteContent.collectionNote,
      SiteContent.legalIntroPrivacy,
      SiteContent.legalIntroTerms,
    ];
    for (final value in strings) {
      expect(value.zh.trim(), isNotEmpty);
      expect(value.en.trim(), isNotEmpty);
    }
  });
}
