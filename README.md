


<h1 align="center">
<img alt="" title="" src="https://cdn.icon-icons.com/icons2/572/PNG/512/1457055658_App_Development_icon-icons.com_54712.png" width="100" /><br>
Clean code
  <!-- trocar: 'você pode colocar uma imagem (logo) que represente seu projeto (visualmente) -->
</h1>

<h2 align="center">Curiosidades sobre os numeros</h2>

<p align="center">
  <img alt="GitHub language count" src="https://img.shields.io/github/languages/count/Sthaynny/todo_mobx">
  <img alt="Repository size" src="https://img.shields.io/github/repo-size/Sthaynny/todo_mobx">
  <a href="https://github.com/Sthaynny/todo_mobx/commits/master">
    <img alt="GitHub last commit" src="https://img.shields.io/github/last-commit/Sthaynny/todo_mobx">
  </a>
  <a href="https://github.com/Sthaynny/todo_mobx">
    <img alt="Repository issues" src="https://img.shields.io/github/issues/Sthaynny/todo_mobx" width="50px">
  </a>

  <img alt="License" src="https://img.shields.io/badge/license-MIT-brightgreen">
</p>


<p align="center">
  <a href="#bookmark_tabs-tecnologias">Tecnologias</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#-projeto">Projeto</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#images_projeto">Imagens Projeto</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#-como-contribuir">Como contribuir</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#memo-licença">Licença</a>
</p>

<h1 align="center">
    <img alt="" title="" src="https://github.com/Sthaynny/images/blob/main/clean_architecture/image_01.jpeg?raw=true" height="400" />  
    <img alt="" title="" src="https://github.com/Sthaynny/images/blob/main/clean_architecture/image_02.jpeg?raw=true" height="400" />    
    <img alt="" title="" src="https://github.com/Sthaynny/images/blob/main/clean_architecture/gif_01.gif?raw=true" height="400" />  


<br>

## :bookmark_tabs: Tecnologias

Tecnologias ultilizadas no projeto:

- [Flutter](https://flutter.dev/)
- [Dart](https://pub.dev/)
- [Github](https://github.com)
- [Slidy](https://github.com/Flutterando/slidy)
- [Emoji](https://gist.github.com/rxaviers/7360908)

## 💻 Projeto

Esse projeto tem um intuito de ter uma arquitetura clean. É um estudo baseado na play list [Clean architecture](https://www.youtube.com/playlist?list=PLB6lc7nQ1n4iYGE_khpXRdJkJEp9WOech) que é feito um app de curiosidades numericar utilizando TDD.


## 🤔 Como contribuir

- Faça um fork desse repositório;
- Cria uma branch com a sua feature: `git checkout -b minha-feature`;
- Faça commit das suas alterações: `git commit -m 'feat: Minha nova feature'`;
- Faça push para a sua branch: `git push origin minha-feature`.

Para ajudar a manter o padrão escolhido também criamos um arquivo que é chamado antes de todo commit. Este arquivo irá formatar e apontará (se presente) erros no codestyle do seu código. Para habilitar você deverá primeiramente copiá-lo para a pasta de hooks do git. Se estiver desenvolvendo em um macOS, vá para à raiz do projeto e execute o comando abaixo:

    $ sh setup.sh

Se preferir, você pode fazer isso manualmente, primeiro garanta que esteja na raiz do projeto e rode o comando abaixo:

    $ cp pre-commit .git/hooks/pre-commit
    
Após este passo, é necessário dar permissão para que o arquivo seja executado. Basta seguir o seguinte comando:

    $ chmod +x .git/hooks/pre-commit
    
Agora, todo commit que for dado neste projeto, independente de ser em uma ferramenta de UI ou na linha de comando, passará primeiro pela formatação e depois pela análise do linter. Caso tudo esteja ok, o commit será realizado normalmente, caso contrário não será efetivado.
**Curiosidade:** Por baixo dos panos este script basicamente usa as ferramentas de formatação e análise de código do Dart.

Depois que o merge da sua pull request for feito, você pode deletar a sua branch.

## :memo: Licença

Esse projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE.md) para mais detalhes.

