import 'package:ant_icons/ant_icons.dart';
import 'package:drift/drift.dart';
import 'package:drift_dev/api/migrations_native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:purple_task/core/database/app_database.dart';

import 'generated/schema.dart';
import 'generated/schema_v1.dart' as v1;
import 'generated/schema_v2.dart' as v2;

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  late SchemaVerifier verifier;

  setUpAll(() {
    verifier = SchemaVerifier(GeneratedHelper());
  });

  group('simple database migrations', () {
    // These simple tests verify all possible schema updates with a simple (no
    // data) migration. This is a quick way to ensure that written database
    // migrations properly alter the schema.
    const versions = GeneratedHelper.versions;
    for (final (i, fromVersion) in versions.indexed) {
      group('from $fromVersion', () {
        for (final toVersion in versions.skip(i + 1)) {
          test('to $toVersion', () async {
            final schema = await verifier.schemaAt(fromVersion);
            final db = AppDatabase(schema.newConnection());
            await verifier.migrateAndValidate(db, toVersion);
            await db.close();
          });
        }
      });
    }
  });

  test('ant icons migration from v1 to v2 does not corrupt data', () async {
    final oldCategoriesData = <v1.CategoriesData>[
      const v1.CategoriesData(
        id: 0,
        name: 'Category 1',
        color: 123456,
        icon: 0xe8a6,
      ),
      const v1.CategoriesData(
        id: 1,
        name: 'Category 2',
        color: 654321,
        icon: 0xe8a4,
      ),
    ];
    final expectedNewCategoriesData = <v2.CategoriesData>[
      v2.CategoriesData(
        id: 0,
        name: 'Category 1',
        color: 123456,
        icon: AntIcons.folderFilled.codePoint,
      ),
      v2.CategoriesData(
        id: 1,
        name: 'Category 2',
        color: 654321,
        icon: AntIcons.fireFilled.codePoint,
      ),
    ];

    await verifier.testWithDataIntegrity(
      oldVersion: 1,
      newVersion: 2,
      createOld: v1.DatabaseAtV1.new,
      createNew: v2.DatabaseAtV2.new,
      openTestedDatabase: AppDatabase.new,
      createItems: (batch, oldDb) {
        batch.insertAll(oldDb.categories, oldCategoriesData);
      },
      validateItems: (newDb) async {
        expect(
          expectedNewCategoriesData,
          await newDb.select(newDb.categories).get(),
        );
      },
    );
  });
}
