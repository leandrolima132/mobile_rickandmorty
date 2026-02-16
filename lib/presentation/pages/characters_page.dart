import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_rickandmorty/presentation/controllers/character_controller.dart';

import 'widgets/character_card.dart';
import 'widgets/hero_character_section.dart';

class CharactersPage extends ConsumerStatefulWidget {
  const CharactersPage({super.key});

  @override
  ConsumerState<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends ConsumerState<CharactersPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      final controller = ref.read(characterControllerProvider.notifier);
      controller.loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(characterControllerProvider);
    final controller = ref.read(characterControllerProvider.notifier);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Rick and Morty',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.8),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.refresh(),
        color: Theme.of(context).colorScheme.primary,
        child: _buildBody(state),
      ),
    );
  }

  Widget _buildBody(CharacterState state) {
    if (state.isLoading && state.characters.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(
          color: Color(0xFF00D4FF),
        ),
      );
    }

    if (state.error != null && state.characters.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red[400],
              ),
              const SizedBox(height: 16),
              Text(
                'Oops! Something went wrong',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[300],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                state.error ?? 'Unknown error',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[500],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  ref.read(characterControllerProvider.notifier).refresh();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                ),
                child: const Text(
                  'Try Again',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (state.characters.isEmpty) {
      return Center(
        child: Text(
          'No characters found',
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey[400],
          ),
        ),
      );
    }

    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        // Hero Section com primeiro personagem
        if (state.characters.isNotEmpty)
          SliverToBoxAdapter(
            child: HeroCharacterSection(
              character: state.characters.first,
            ),
          ),

        // Grid de personagens
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.65,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index == state.characters.length) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF00D4FF),
                    ),
                  );
                }

                // Pula o primeiro personagem (já está no hero)
                final characterIndex = index + 1;
                if (characterIndex >= state.characters.length) {
                  return const SizedBox.shrink();
                }

                return CharacterCard(
                  character: state.characters[characterIndex],
                );
              },
              childCount: state.characters.length +
                  (state.isLoadingMore ? 1 : 0) -
                  1, // -1 porque o primeiro está no hero
            ),
          ),
        ),

        // Loading indicator no final
        if (state.isLoadingMore)
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF00D4FF),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
