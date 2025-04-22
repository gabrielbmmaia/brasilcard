# 📱 BrasilCard

O **BrasilCard** é um aplicativo mobile desenvolvido em Flutter que utiliza a [API CoinCap](https://pro.coincap.io/api-docs) para fornecer dados atualizados sobre o mercado de criptomoedas. Com ele, é possível acompanhar o ranking de criptoativos, favoritar moedas para acompanhar em tempo real, e visualizar o histórico de preços com detalhes.

Mesmo sendo um projeto de escopo reduzido, foram aplicadas boas práticas de **código limpo**, **escalabilidade** e **manutenibilidade**. Foram utilizadas **injeção de dependência** com `get_it`, seguindo princípios do **SOLID**, e adotadas **nomenclaturas intuitivas**, códigos simples e reutilizáveis, em conformidade com os princípios **DRY (Don't Repeat Yourself)** e **KISS (Keep It Simple, Stupid)**.

Além disso, foi implementado o padrão arquitetural **MVVM**, atendendo aos requisitos de estruturação do projeto. Para segurança, a chave da API foi protegida utilizando **Platform Channels**, evitando a exposição em código Dart. Para otimização de recursos, foi aplicada **paginação de dados**, evitando requisições desnecessárias à API.

Essas e outras práticas reforçam o compromisso do projeto com qualidade, segurança e performance, mesmo em contextos de menor complexidade.

## 📌 Índice
- [🎨 Layouts do Projeto](#🎨-layouts-do-projeto)
- [⚙️ Funcionalidades](#⚙️-funcionalidades)
- [🛠️ Tecnologias e Técnicas](#🛠️-tecnologias-e-técnicas)
- [🧭 Navegação entre Telas](#🧭-navegação-entre-telas)
- [📲 Funcionalidades por Tela](#📲-funcionalidades-por-tela)
- [🔗 API Utilizada](#🔗-api-utilizada)
- [🚀 Como Rodar o Projeto](#🚀-como-rodar-o-projeto)
- [🎥 Showcase do Aplicativo](#🎥-showcase-do-aplicativo)

## 🎨 Layouts do Projeto

Aqui você pode conferir uma visão geral de todas as telas do app:

🛠️ _[Imagem em desenvolvimento]_

## ⚙️ Funcionalidades

- 📊 Listagem em tempo real do ranking de criptomoedas fornecido pela CoinCap.
- ⭐ Possibilidade de favoritar criptomoedas para monitoramento personalizado.
- 📈 Visualização detalhada de informações e histórico de preços (30 dias, 90 dias, 180 dias, 1 ano, 2 anos).

## 🛠️ Tecnologias e Técnicas

- `Flutter`: framework escolhido para desenvolvimento multiplataforma.
- `Dart`: linguagem principal do projeto.
- `Git & GitHub`: versionamento e hospedagem do código.
- `HTTP`: integração com a API CoinCap.
- `Get_it`: gerenciador de injeção de dependências.
- `Shared Preferences`: armazenamento do ThemeMode do app.
- `MobX`: gerenciamento de estados com reatividade.
- `MVVM`: padrão arquitetural utilizado.
- `Testes Unitários`: cobertura de testes para todas as funcionalidades.
- `Hive`: persistência de dados local.
- `Flutter ScreenUtil`: adaptação de layout para múltiplos tamanhos de tela.
- `Go_router`: gerenciamento de rotas e navegação.
- `FL Chart`: criação de gráficos dinâmicos.
- `Infinite Scroll Pagination`: paginação eficiente de grandes volumes de dados.
- `Platform Channels`: ocultação da chave de API em código nativo.

## 🧭 Navegação entre Telas

🛠️ _[Imagem em desenvolvimento]_

## 📲 Funcionalidades por Tela

### 🏠 Home
- Pesquisar por nome ou símbolo de criptomoedas.
- Alteração entre temas claro e escuro.
- Adição e remoção de favoritos com um toque.

🛠️ _[Imagem em desenvolvimento]_

### 📊 Detalhes da Criptomoeda
- Exibição completa de informações da moeda selecionada.
- Histórico de preços filtrado por: 30 dias, 90 dias, 180 dias, 1 ano ou 2 anos.

🛠️ _[Imagem em desenvolvimento]_

### ⭐ Favoritos
- Acompanhamento de todas as moedas favoritas.
- Opções para remover individualmente ou todas criptomoedas.

🛠️ _[Imagem em desenvolvimento]_

## 🔗 API Utilizada (22/04/2025)

- [📘 CoinCap API Documentation](https://pro.coincap.io/api-docs)

## 🚀 Como Rodar o Projeto

## 🎥 Showcase do Aplicativo

<div align="center">
 <video src="https://github.com/user-attachments/assets/e251048f-a3c2-4fe5-953d-5c7cdfe2b477" width="800" controls />
</div>
