# 🎵 Moises App – Desafio Técnico

Aplicativo iOS desenvolvido em **Swift 6** que permite buscar músicas utilizando a **API do iTunes**, com uma interface construída em **SwiftUI**, arquitetura MVVM e foco em simplicidade, performance e organização de código.

---

## ▶️ Como rodar o projeto localmente

1. Clone o repositório:

   ```bash
   git clone git@github.com:luizgustavogp/Moises.git
   cd Moises
   ```

2. Instale as dependências com CocoaPods:

   ```bash
   pod install
   ```

3. Abra o projeto com o workspace:

   ```bash
   open Moises.xcworkspace
   ```

4. Selecione um simulador e execute o app com `Cmd + R`

> ✅ Requisitos: Xcode 15.3+ e CocoaPods instalado

---

## 📦 Bibliotecas utilizadas

- [`Kingfisher`](https://github.com/onevcat/Kingfisher) – Para carregamento e cache de imagens  
- [`ViewInspector`](https://github.com/nalexn/ViewInspector) – Para inspeção de Views em testes unitários SwiftUI

## 📽️ Demonstração


<video src="https://github.com/user-attachments/assets/1cbcf1b7-06e6-4955-8e9a-f5d61cf1fb08" controls width="600"></video>
<video src="https://github.com/user-attachments/assets/30d67007-4c6e-455a-bbab-b26d032773c4" controls width="600"></video>
<video src="https://github.com/user-attachments/assets/9baf8326-f7fd-4705-abdf-2738565a8a1f" controls width="600"></video>

---

### Telas obrigatórias:

- ✅ Splash Screen  
- ✅ Songs Screen (Home)  
- ✅ Song Details (Player)  
- ✅ Bottom Sheet com mais opções  
- ✅ Album Screen

### Requisitos obrigatórios:

- ✅ Uso de **Swift 6**  
- ✅ Arquitetura **MVVM**  
- ✅ **Testes implementados**  
- ✅ **Paginação** nos resultados da API  

---

## ✨ Funcionalidades extras entregues

- ✅ **Controle de tela vazia** quando não há resultados  
- ✅ **Tema claro e escuro**  
- ✅ Splash Screen personalizada  
- ✅ Player implementado em memória apenas para demonstração (a API do iTunes não fornece áudio completo)  

---

## 🧠 O que eu aprendi

- Uso prático do novo framework de **Swift Testing**, com foco em testes unitários e validação de estados da `ViewModel`

---

## 💡 Pontos Positivos

- Projeto escrito com **Swift 6**  
- Uso de **SwiftUI**, **Concurrency** e **Combine**  
- Arquitetura clara, modular e reutilizável  

---

## ⚠️ Pontos de Atenção

- A lógica de scroll infinito funciona, mas pode ser aprimorada. Atualmente é feita com base na verificação do último item visível.

---

## 🚀 Melhorias Futuras

- Adicionar sugestões automáticas no campo de busca  
- Permitir injeção de `scheduler` nos testes da ViewModel  
- Extrair os módulos `DSM` e `Networking` como bibliotecas internas  
- Implementar um player real com streaming (caso a API permita)  

---

## 📝 Considerações de Design

Algumas decisões visuais foram adaptadas:

- A **Splash Screen** foi ajustada por decisão própria  
- A **TabBar** foi incluída para melhorar a navegação  
- Implementação de **tema claro/escuro**

> Em ambiente real, seguiria a proposta definida pelo time de UX. Mudanças visuais seriam discutidas e sugeridas em conjunto.
