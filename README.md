# Back-end Challenge 🏅 2021 - Space Flight News

Visão do projeto:
Projeto com objetivo de atender as especificações do desafio, se fosse na vida real eu teria várias perguntas para os stakeholders.

#### Minhas Decisões:

* Decidi em usar docker para facilitar o deploys
* Optei em pluralizar em 2 linguagens de programação(Ruby e Python) pois são duas linguagens que atualmente me sinto mais produtivo.
* Decidi separar em 3 aplicação para ficar fácil de escalar, principalmente o subscriber
* Decidi chamar a api(rails) no projeto subscribe, essa decisão tem impacto quando colocamos a primeira carga de dados, deixando assim a api lenta até finalizar todos os inserts. Eu poderia me conectar ao banco de dados pelo subscriber e fazer os insert, dessa forma não iria comprometer a api.


### Linguagem, framework e/ou tecnologias usadas

* 1\. Docker/docker-compose para provisionamento do ambiente
* 2\. Ruby on rails (Usado para criar a api de articles)
  * 2.1 [rspec-rails](https://github.com/rspec/rspec-rails) (Testes)
  * 2.2 [faker](https://github.com/faker-ruby/faker) (Testes)
  * 2.3 [kaminari](https://github.com/kaminari/kaminari) (Paginação)
* 3\. Postgresql (Banco de dados Relacional)
* 4\. Python (Publisher e Subscriber)
  * 4.1 [requests](https://docs.python-requests.org/en/latest/user/quickstart/) (HTTP library)
  * 4.2 [pika](https://pika.readthedocs.io/en/stable/) (Comunicação com o RabbitMQ) 
* 5\. RabbitMQ (Servidor de mensageria)

### Instação da aplicação

Para esse projeto você vai **precisar ter o docker instalado** na sua Máquina

1. Faça o clone do projeto
  ```
   git clone https://github.com/jhonattasantos/space_flight_news.git space_flight_news
  ```
2. Entre no diretorio
  ```
   cd space_flight_news
  ```

3. Rode os comando abaixo para subir a aplicação(*Obs: As portas do 5435, 3000, 5672 e 15672 vão ser utilizadas*):
```
make dev
```
4. Para importar os dados do projeto Space Flight News e colocar no RabbitMQ

```
make pub
```

Caso queira acompanhar os logs:
```
make pub-log
```

5. Para cadastrar os dados no Postgres

```
make sub
```

Caso queira acelerar o processo, você pode escalar o serviço do subscriber, no exemplo abaixo estou escalando para 10
```
docker-compose scale space-subscriber-app=10
```

Caso queira acompanhar os logs
```
make sub-log
```

Após 1 minuto todos os dados serão migrados para o banco de dados local

## Testando a api

#### postman
Coloquei uma collection do postman na raiz do projeto para auxiliar caso você use essa ferramenta para testes.

#### rspec
Execute o comando abaixo para executar os testes unitarios

```
make unit-test
```