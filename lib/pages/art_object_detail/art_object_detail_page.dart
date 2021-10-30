import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:flutter_test_app/managers/navigation_manager.dart';
import 'package:flutter_test_app/managers/notification_manager.dart';
import 'package:flutter_test_app/pages/art_object_detail/bloc/art_object_detail_bloc.dart';
import 'package:flutter_test_app/pages/art_object_detail/bloc/art_object_detail_event.dart';
import 'package:flutter_test_app/pages/art_object_detail/art_object_detail_view.dart';
import 'package:test_app_domain/test_app_domain.dart';

class ArtObjectDetailPage extends StatelessWidget {
  const ArtObjectDetailPage({
    required this.artObject,
    Key? key,
  }) : super(key: key);

  final ArtObject artObject;

  @override
  Widget build(BuildContext context) {
    final injector = Injector();
    return BlocProvider(
      create: (context) {
        return ArtObjectDetailBloc(
          repository: injector.get<IArtObjectRepository>(),
          artObject: artObject,
        )..add(ArtObjectDetailEvent.fetchFullContent(artObject.objectNumber));
      },
      child: ArtObjectDetailView(
        notificationManager: injector.get<INotificationManager>(),
        navigationManager: injector.get<INavigationManager>(),
      ),
    );
  }
}
