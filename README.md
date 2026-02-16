# 🚀 Rick and Morty Character Explorer

Um aplicativo Flutter desenvolvido para estudo, que permite explorar os personagens da série Rick and Morty. O app consome a [Rick and Morty API](https://rickandmortyapi.com/) e apresenta os personagens em um layout moderno inspirado em apps de streaming.

## 📱 Sobre o Projeto

Este projeto foi desenvolvido com o objetivo de estudar e praticar conceitos de desenvolvimento mobile com Flutter, incluindo:

- Arquitetura limpa (Clean Architecture)
- Gerenciamento de estado com Riverpod
- Consumo de APIs REST
- Design moderno e responsivo
- Animações e transições suaves

## ✨ Funcionalidades

- 🎬 **Splash Screen Animada** - Tela inicial com GIF animado do Rick and Morty
- 👥 **Lista de Personagens** - Grid moderno com scroll infinito
- 🎯 **Hero Section** - Destaque para o primeiro personagem
- 📄 **Detalhes do Personagem** - Tela completa com todas as informações
- 🔄 **Pull to Refresh** - Atualização da lista
- ♾️ **Scroll Infinito** - Carregamento automático de mais personagens
- 🎨 **Design Moderno** - Interface inspirada em apps de streaming (Crunchyroll)

## 🛠️ Tecnologias Utilizadas

### Core
- **Flutter** - Framework de desenvolvimento
- **Dart** - Linguagem de programação (SDK >=3.4.0)

### Gerenciamento de Estado
- **flutter_riverpod** (^2.6.1) - Gerenciamento de estado reativo

### Networking
- **dio** (^5.9.1) - Cliente HTTP para requisições à API

### Storage
- **shared_preferences** (^2.3.3) - Armazenamento local de dados

## 🏗️ Arquitetura

O projeto segue os princípios de **Clean Architecture**, organizando o código em camadas:

```
lib/
├── core/                    # Camada de infraestrutura
│   ├── datasources/        # Fontes de dados (API)
│   ├── service/            # Serviços (API Service)
│   └── utils/              # Utilitários
├── domain/                 # Camada de domínio
│   ├── entities/           # Entidades de negócio
│   ├── models/             # Modelos de dados da API
│   └── mappers/            # Conversores Model -> Entity
└── presentation/           # Camada de apresentação
    ├── controllers/        # Controllers (Riverpod)
    └── pages/             # Telas e widgets
```

### Princípios Aplicados

- **Separation of Concerns** - Cada camada tem responsabilidade única
- **Dependency Inversion** - Dependências apontam para abstrações
- **Single Responsibility** - Cada classe tem uma única responsabilidade

## 📂 Estrutura do Projeto

```
lib/
├── core/
│   ├── datasources/
│   │   ├── character_datasource.dart          # Interface do datasource
│   │   └── character_datasource_impl.dart     # Implementação
│   ├── service/
│   │   └── api_service.dart                   # Serviço HTTP
│   └── utils/
│       ├── character_utils.dart               # Utilitários de personagem
│       └── storage_utils.dart                 # Utilitários de storage
│
├── domain/
│   ├── entities/
│   │   └── character.dart                    # Entidade de domínio
│   ├── models/
│   │   ├── character_model.dart              # Modelo da API
│   │   ├── character_response_model.dart      # Resposta da API
│   │   └── infor_model.dart                  # Modelo de paginação
│   └── mappers/
│       └── character_mapper.dart             # Mapper Model -> Entity
│
└── presentation/
    ├── controllers/
    │   └── character_controller.dart          # Controller Riverpod
    └── pages/
        ├── splash_page.dart                  # Tela de splash
        ├── characters_page.dart              # Lista de personagens
        ├── character_detail_page.dart        # Detalhes do personagem
        └── widgets/
            ├── character_card.dart           # Card de personagem
            └── hero_character_section.dart   # Hero section
```

## 🚀 Como Executar

### Pré-requisitos

- Flutter SDK (>=3.4.0)
- Dart SDK (>=3.4.0)
- FVM (Flutter Version Management) - opcional mas recomendado

### Instalação

1. Clone o repositório:
```bash
git clone https://github.com/leandrolima132/mobile_rickandmorty.git
cd mobile_rickandmorty
```

2. Instale as dependências:
```bash
fvm flutter pub get
```

3. Execute o app:
```bash
fvm flutter run
```

### Configuração do FVM (Opcional)

Se você usa FVM, certifique-se de ter uma versão do Flutter configurada:
```bash
fvm install
fvm use
```

## 📱 Telas

### Splash Screen
- Animação com GIF do Rick and Morty
- Transição suave para a tela principal
- Duração de 3 segundos

### Lista de Personagens
- Hero section com primeiro personagem em destaque
- Grid de 2 colunas com cards dos personagens
- Scroll infinito para carregar mais personagens
- Pull to refresh para atualizar a lista

### Detalhes do Personagem
- Imagem em destaque com SliverAppBar
- Informações completas do personagem
- Status, espécie, tipo, gênero
- Localização atual e origem
- Número de episódios
- Data de criação

## 🎨 Design

O app utiliza um tema escuro moderno com:
- **Cores principais**: Ciano (#00D4FF) e Laranja (#FF6B35)
- **Background**: Preto (#0A0A0A)
- **Cards**: Cinza escuro (#1A1A1A)
- **Material Design 3**: Habilitado

## 🔧 Funcionalidades Técnicas

### Gerenciamento de Estado
- **Riverpod** para gerenciamento de estado reativo
- **StateNotifier** para lógica de negócio
- Providers para injeção de dependências

### Consumo de API
- **Dio** para requisições HTTP
- Tratamento de erros
- Interceptors para logs e autenticação
- Paginação automática

### Performance
- Scroll infinito otimizado
- Cache de imagens
- Lazy loading de widgets
- Dispose correto de recursos

## 📚 Conceitos Aprendidos

Este projeto foi desenvolvido para estudo e prática dos seguintes conceitos:

- ✅ Clean Architecture
- ✅ Gerenciamento de estado com Riverpod
- ✅ Consumo de APIs REST
- ✅ Paginação e scroll infinito
- ✅ Animações e transições
- ✅ Hero animations
- ✅ CustomScrollView e Slivers
- ✅ Tratamento de erros
- ✅ Memory management (dispose, timers)
- ✅ Code organization e DRY principles

## 🐛 Tratamento de Erros

- Validação de resposta da API
- Fallback para imagens que não carregam
- Mensagens de erro amigáveis
- Botão de retry em caso de falha

## 📝 Melhorias Futuras

- [ ] Busca de personagens
- [ ] Filtros (status, espécie, gênero)
- [ ] Favoritos
- [ ] Cache offline
- [ ] Testes unitários e de integração
- [ ] Internacionalização (i18n)
- [ ] Modo claro/escuro
- [ ] Compartilhamento de personagens

## 🤝 Contribuindo

Este é um projeto de estudo, mas sugestões e melhorias são bem-vindas! Sinta-se à vontade para abrir issues ou pull requests.

## 📄 Licença

Este projeto é de código aberto e está disponível para fins educacionais.

## 👨‍💻 Autor

**Leandro Lima**

- GitHub: [@leandrolima132](https://github.com/leandrolima132)
- Projeto desenvolvido para estudo e aprendizado

## 🙏 Agradecimentos

- [Rick and Morty API](https://rickandmortyapi.com/) - API gratuita e incrível
- Flutter Team - Framework fantástico
- Comunidade Flutter - Por toda a documentação e suporte

---

⭐ Se este projeto foi útil para você, considere dar uma estrela!
