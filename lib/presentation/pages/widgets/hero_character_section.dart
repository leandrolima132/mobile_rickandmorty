import 'package:flutter/material.dart';
import 'package:mobile_rickandmorty/core/utils/character_utils.dart';
import 'package:mobile_rickandmorty/domain/entities/character.dart';
import 'package:mobile_rickandmorty/presentation/pages/character_detail_page.dart';

class HeroCharacterSection extends StatelessWidget {
  final Character character;

  const HeroCharacterSection({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                CharacterDetailPage(character: character),
            transitionDuration: const Duration(milliseconds: 400),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        );
      },
      child: Container(
        height: 500,
        margin: const EdgeInsets.only(bottom: 24),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Imagem de fundo
            Hero(
              tag: 'hero_${character.id}',
              child: Image.network(
                character.image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[900],
                    child: const Icon(
                      Icons.person,
                      size: 100,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),

            // Gradiente overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.3),
                    Colors.black.withOpacity(0.8),
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),

            // Conteúdo
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Status badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: CharacterUtils.getStatusColor(character.status),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            character.status.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Nome
                    Text(
                      character.name,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.black,
                            blurRadius: 10,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Informações
                    Text(
                      '${character.species} • ${character.gender}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[300],
                        shadows: const [
                          Shadow(
                            color: Colors.black,
                            blurRadius: 8,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Localização
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 16,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            character.location,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[400],
                              shadows: const [
                                Shadow(
                                  color: Colors.black,
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
