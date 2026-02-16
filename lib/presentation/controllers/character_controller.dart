import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_rickandmorty/core/datasources/character_datasource_impl.dart';
import 'package:mobile_rickandmorty/domain/entities/character.dart';

final characterDatasourceProvider = Provider<CharacterDatasourceImpl>((ref) {
  return CharacterDatasourceImpl();
});

class CharacterState {
  final List<Character> characters;
  final bool isLoading;
  final bool isLoadingMore;
  final String? error;
  final int currentPage;
  final bool hasMore;

  CharacterState({
    this.characters = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
    this.currentPage = 1,
    this.hasMore = true,
  });

  CharacterState copyWith({
    List<Character>? characters,
    bool? isLoading,
    bool? isLoadingMore,
    String? error,
    int? currentPage,
    bool? hasMore,
  }) {
    return CharacterState(
      characters: characters ?? this.characters,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

class CharacterController extends StateNotifier<CharacterState> {
  final CharacterDatasourceImpl _datasource;

  CharacterController(this._datasource) : super(CharacterState()) {
    loadCharacters();
  }

  Future<void> loadCharacters({bool refresh = false}) async {
    if (refresh) {
      state = CharacterState();
    }

    if (state.isLoading || state.isLoadingMore) return;

    try {
      if (state.currentPage == 1) {
        state = state.copyWith(isLoading: true, error: null);
      } else {
        state = state.copyWith(isLoadingMore: true, error: null);
      }

      final characters =
          await _datasource.getCharacters(page: state.currentPage);

      state = state.copyWith(
        characters: refresh ? characters : [...state.characters, ...characters],
        isLoading: false,
        isLoadingMore: false,
        hasMore: characters.isNotEmpty,
        currentPage: state.currentPage + 1,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        isLoadingMore: false,
        error: e.toString(),
      );
    }
  }

  Future<void> loadMore() async {
    if (state.hasMore && !state.isLoadingMore && !state.isLoading) {
      await loadCharacters();
    }
  }

  Future<void> refresh() async {
    await loadCharacters(refresh: true);
  }
}

final characterControllerProvider =
    StateNotifierProvider<CharacterController, CharacterState>((ref) {
  final datasource = ref.watch(characterDatasourceProvider);
  return CharacterController(datasource);
});
