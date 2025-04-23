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

![layout_geral](https://github.com/user-attachments/assets/c15fe9f6-f768-46bb-be38-22af9858a856)

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

## 📲 Funcionalidades por Tela

### 🏠 Home
- Pesquisar por nome ou símbolo de criptomoedas.
- Alteração entre temas claro e escuro.
- Adição e remoção de favoritos com um toque.

![layout_home](https://github.com/user-attachments/assets/68d7f019-9362-4ef2-a84b-c586f5e3afe4)

### 📊 Detalhes da Criptomoeda
- Exibição completa de informações da moeda selecionada.
- Histórico de preços filtrado por: 30 dias, 90 dias, 180 dias, 1 ano ou 2 anos.

![layout_details](https://github.com/user-attachments/assets/88b1c717-160a-449f-8743-7b0266fa75f9)

### ⭐ Favoritos
- Acompanhamento de todas as moedas favoritas.
- Opções para remover individualmente ou todas criptomoedas.

![favorite_layout](https://github.com/user-attachments/assets/f40f0141-efc3-4ff0-8b28-d979544f7c64)

## 🔗 API Utilizada (22/04/2025)

- [📘 CoinCap API Documentation](https://pro.coincap.io/api-docs)

## 🚀 Como Rodar o Projeto
1. Acesse a aba **`Releases`** localizada no lado direito da página (ou abaixo do **README**, se você estiver acessando pelo celular).
2. Clique na versão chamada **`first_version`**.
3. Você verá três arquivos listados — clique em **`app-release.apk`**.
4. Em seguida, clique em **`Baixar`** para iniciar o download.

> ⚠️ **Atenção:** Caso seu celular não permita instalar apps de fontes externas (fora da Play Store), será necessário ativar essa opção nas configurações do dispositivo.

Depois disso, é só abrir o aplicativo e aproveitar! 😄

## 🎥 Showcase do Aplicativo

<div align="center">
 <video src="https://github.com/user-attachments/assets/e251048f-a3c2-4fe5-953d-5c7cdfe2b477" width="800" controls />
</div>
