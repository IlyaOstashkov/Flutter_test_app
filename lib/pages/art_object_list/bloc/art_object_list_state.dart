import 'package:flutter_test_app/pages/art_object_list/view_models/art_object_list_view_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'art_object_list_state.freezed.dart';

@freezed
abstract class ArtObjectListState with _$ArtObjectListState {
  const factory ArtObjectListState.initialLoading() =
      _ArtObjectListStateInitialLoading;
  const factory ArtObjectListState.content(
    List<ArtObjectListViewModel> listItems,
    bool reachedMax,
    int century,
    int fetchPage,
  ) = _ArtObjectListStateContent;
  const factory ArtObjectListState.error(String errorMessage) =
      _ArtObjectListStateError;
}
