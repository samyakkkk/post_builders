import 'dart:async';

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

Builder saverBuilder(BuilderOptions options) {
  return LibraryBuilder(SaverBuilder(),
      allowSyntaxErrors: true,
      options: BuilderOptions({
        "build_extensions": {
          '.dart': ['.save_wt.dart'],
        }
      }));
}

PostProcessBuilder deleterBuilder = DeleterBuilder();

class DeleterBuilder extends PostProcessBuilder {
  @override
  FutureOr<void> build(PostProcessBuildStep buildStep) async {
    print("Deleter Builder Running");
    final assetId = buildStep.inputId;
    print("asset path: ${assetId.path}");
    buildStep.deletePrimaryInput();
  }

  @override
  Iterable<String> get inputExtensions => ['.save_wt.dart'];
}

class SaverBuilder extends Generator {
  @override
  FutureOr<String?> generate(LibraryReader library, BuildStep buildStep) async {
    print("Saver Builder Running");
    final assetId = await buildStep.resolver.assetIdForElement(library.element);
    print("asset path: ${assetId.path}");
    final mockId = assetId.changeExtension('.save_wt.dart');
    buildStep.writeAsString(mockId, "//${assetId.path}");
    return '';
  }
}
