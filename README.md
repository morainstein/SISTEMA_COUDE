# ESTRUTURA PARA DESENVOLVIMENTO DO SISTEMA DA COUDE

Os únicos arquivos php no diretório raiz serão o arquivo index (página principal do sistema) e o arquivo de login. Todos os demais arquivos estaram dispostos no diretório `gerenciamento`, seguindo uma estrutura similar a:
 ```
  - gerenciamento
    - usuarios
    - polos
      - unidades
        - salas
    - cursos
    - turmas

    ## esta estrutura é um exemplo
 ```

 Inicialmente, não aplicaremos distinção do nível de acesso no código, consideramemos que o único usuário será o usuário master, depois de finalizadas as funcionalidades nesse sentido, adicionaremos as distinções pelos tipos de usuários


 **NOTA:** toda a estrutura previamente criada de pastas e arquivos serve apenas para nortear o desenvolvimento podendo, enventualmente, tornar-se desnecessária ou insuficiente, cabe a vocês gerenciar isto.

 ## Sobre os diretórios

 ### `/gerenciamento`
  Este diretório é onde estarão contidas as páginas do sistema (como já mencionado, exceto a de login e a principal).

  Ele será dividido de acordo com as categorias do sistema, visando ter uma definições de rotas mais interessante.

  NOTA: o objetivo dos arquivos deste diretório é possibilitar a configuração de rotas mais interessantes, é importante lembrar de que o conteúdo das páginas, em si, caso seja possível, será modulado (como cabeçalhos, rodapés, imports...) e estará contido no diretório `/src/componentes`

 ### `/assets`
  Essa pasta deve conter todos os arquivos estáticos do sistema, como CSS, JS e imagens. 
  IMPORTANTE: **arquivos estáticos do sistema**

 ### `/uploads`
  Esta página é apenas para upload de arquivos dos usuários, como, por exemplo, os arquivos dos exercícios...

  é interessante que o upload de arquivos seja feito considerando a estrutura de pastas das categorias do sistema. (os exercícios, por exemplo, seriam enviados para `/uploads/turmas/exercicios`, **EXEMPLO**)

  ```
   - uploads
    - usuarios
    - polos
      - unidades
        - salas
    - cursos
    - turmas
  ```

 ### `/api/get`
  Caso, em alguma página, seja necessário aplicar uma requisição fetch para puxar informações, a requisição deverá ser feita para este diretório.

  Vale salientar que o interessante é dispor os arquivos de acordo com as categorias do sistema

  ```
   - api
    - get
      - usuarios
      - polos
        - unidades
          - salas
      - cursos
      - turmas
  ```

 ### `/api/post`
  Os formulários de cadastro, edição, ou exclusão do sistema serão todos enviados para cá.

  Vale salientar que o interessante é dispor os arquivos de acordo com as categorias do sistema

  ```
   - api
    - post
      - usuarios
      - polos
        - unidades
          - salas
      - cursos
      - turmas
  ```

 ### `/src/Model`
  Este diretório é, basicamente, a representação, através das classes, do banco de dados.

 ### `/src/Controler`
  Este diretório é, basicamente, a representação, através das classes, dos casos de uso do sistema.

 ### `/src/componentes`
  Este diretório visa conter os módulos do sistema: cabeçalhos, rodapés, imports, etc.

 ### `/src/recursos`
  Aqui estarão contidos arquivos que são necessários para auxiliar o funcionamento do sistema, principalmente arquivos com funções para auxílio das funcionalidades do sistema.