import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_app/navigation/app_navigation_stack.dart';
import 'package:flutter_test_app/navigation/navigation_stack_item.dart';
import 'package:test_app_blocs/test_app_blocs.dart';
import 'package:test_app_domain/test_app_domain.dart';
import 'package:test_app_ui_kit/test_app_ui_kit.dart';

class ArtObjectDetailView extends StatefulWidget {
  const ArtObjectDetailView({Key? key}) : super(key: key);

  @override
  _ArtObjectDetailView createState() => _ArtObjectDetailView();
}

class _ArtObjectDetailView extends State<ArtObjectDetailView> {
  void _onImageTap(ArtObject artObject) {
    final imageUrl = artObject.imageUrl;
    if (imageUrl == null) return;
    AppNavigationStack.instance
        .push(NavigationStackItem.fullScreenImage(imageUrls: [imageUrl]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarFabric.simpleAppBar(title: 'Art object'),
      body: BlocListener<ArtObjectDetailBloc, ArtObjectDetailState>(
        listener: (context, state) {
          state.maybeWhen(
            error: (errorMessage) {
              final message = errorMessage.isNotEmpty
                  ? errorMessage
                  : 'Failed to fetch additional information';
              final snack = SnackBarWidget.of(context);
              if (snack != null) snack.show(context, message);
            },
            orElse: () {},
          );
        },
        child: BlocBuilder<ArtObjectDetailBloc, ArtObjectDetailState>(
          builder: (context, state) {
            return ListView(
              children: [
                const OffsetSpace.vertical(OffsetValue.big),
                ...state.when(
                  initialLoading: () {
                    return [Container()];
                  },
                  partialContent: (artObject) {
                    return [
                      _TopViews(
                        artObject: artObject,
                        onImageTap: () => _onImageTap(artObject),
                      ),
                      const _Loader(),
                    ];
                  },
                  fullContent: (artObject) {
                    return [
                      _TopViews(
                        artObject: artObject,
                        onImageTap: () => _onImageTap(artObject),
                      ),
                      _AdditionalViews(artObject: artObject),
                    ];
                  },
                  error: (errorMessage) {
                    return [Container()];
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _AdditionalViews extends StatelessWidget {
  const _AdditionalViews({
    required this.artObject,
    Key? key,
  }) : super(key: key);

  final ArtObject artObject;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const OffsetSpace.vertical(),
        if ((artObject.description ?? '').isNotEmpty) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const OffsetSpace.horizontal(),
              _RegularText(text: artObject.description!),
              const OffsetSpace.horizontal(),
            ],
          ),
          const OffsetSpace.vertical(),
        ],
        if ((artObject.principalOrFirstMaker ?? '').isNotEmpty) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const OffsetSpace.horizontal(),
              _GreyText(text: artObject.principalOrFirstMaker!),
              const OffsetSpace.horizontal(),
            ],
          ),
          const OffsetSpace.vertical(),
        ],
        if ((artObject.presentingDate ?? '').isNotEmpty) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const OffsetSpace.horizontal(),
              _RegularText(text: artObject.presentingDate!),
              const OffsetSpace.horizontal(),
            ],
          ),
          const OffsetSpace.vertical(),
        ],
      ],
    );
  }
}

class _RegularText extends StatelessWidget {
  const _RegularText({
    required this.text,
    Key? key,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SimpleText(
        text,
        textAlign: TextAlign.center,
        textStyle: const TextStyle(fontSize: 14.0),
        maxLines: 50,
      ),
    );
  }
}

class _TopViews extends StatelessWidget {
  const _TopViews({
    required this.artObject,
    required this.onImageTap,
    Key? key,
  }) : super(key: key);

  final ArtObject artObject;
  final VoidCallback onImageTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _Image(
              imageRadius: 100.0,
              imageUrl: artObject.imageUrl,
              onTap: onImageTap,
            ),
          ],
        ),
        const OffsetSpace.vertical(OffsetValue.big),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const OffsetSpace.horizontal(),
            _Title(title: artObject.title),
            const OffsetSpace.horizontal(),
          ],
        ),
        const OffsetSpace.vertical(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const OffsetSpace.horizontal(),
            _GreyText(text: artObject.objectNumber),
            const OffsetSpace.horizontal(),
          ],
        ),
      ],
    );
  }
}

class _GreyText extends StatelessWidget {
  const _GreyText({
    required this.text,
    Key? key,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SimpleText(
        text,
        textAlign: TextAlign.center,
        textStyle: const TextStyle(
          fontSize: 14.0,
          color: Colors.black38,
        ),
        maxLines: 2,
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    required this.title,
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SimpleText(
        title,
        textAlign: TextAlign.center,
        textStyle: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
        maxLines: 5,
      ),
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({
    required this.imageRadius,
    required this.imageUrl,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final double imageRadius;
  final String? imageUrl;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return CircleLoadableImage(
      borderWidth: 2.0,
      radius: imageRadius,
      imageUrl: imageUrl,
      placeholder: const Icon(
        Icons.color_lens,
        color: Colors.black12,
        size: 100.0,
      ),
      onTap: onTap,
    );
  }
}

class _Loader extends StatelessWidget {
  const _Loader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [SimpleLoader()],
      ),
    );
  }
}
