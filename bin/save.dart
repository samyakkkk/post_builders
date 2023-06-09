/*
 * Created on Tue Mar 07 2023
 *
 * Copyright (C) 2023 PixelApps - All Rights Reserved
 * The code in this file is Intellectutal Property of PixelApps
 * and can't be edited, redistributed or used without a valid license of it's product (Welltested)[https://welltested.ai]
 */
import 'package:build_runner_core/build_runner_core.dart' as build_runner_core;
import 'package:post_builders/builders.dart' as post_builders;
import 'package:build_runner/build_runner.dart' as build_runner;
import 'dart:io' as io;

final _builders = <build_runner_core.BuilderApplication>[
  build_runner_core.apply(r'post_builders:saver', [post_builders.saverBuilder],
      build_runner_core.toDependentsOf(r'post_builders'),
      hideOutput: true),
  build_runner_core.applyPostProcess(
      r'post_builders:deleterBuilder', post_builders.deleterBuilder)
];
Future<void> main(List<String> args) async {
  build_runner_core.overrideGeneratedOutputDirectory('save_cache');
  final result = await build_runner.run(args, _builders);
  io.exitCode = result;
}
