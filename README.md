<h3 align="center">Resturando Base de Dados Aberta de Obras(GeoPB) do TCE-PB</h3>

<div align="center">

[![Status](https://img.shields.io/badge/status-active-success.svg)]()
[![License](https://img.shields.io/badge/licence-GNU%20Aferro%20V3-blue.svg)](/LICENSE)

</div>

---

<p align="center">
    <br> 
</p>

## 📝 Índice

- [Sobre](#about)
- [Pré-Requisitos](#req)
- [Uso](#usage)


## 🧐 Sobre <a name = "about"></a>

Este repositório fornece meios, através do docker, para facilitar o uso dos dados abertos de obras oriundos do [Tribunal de Contas do estado da Paraíba](https://tce.pb.gov.br/servicos/dados-abertos-do-sagres-tce-pb). Com ele é possível restaurar o banco PostgreSQL do GeoPB com todos os pacotes necessários para o funcionamento da aplicação, como dependências e bibliotecas.

### 🎈 Pré-requisitos <a name="req"></a>

- Os serviços utilizam docker para configuração do ambiente e execução do script. Instale o  [docker](https://docs.docker.com/install/) e tenha certeza que você também tem o  [docker-compose](https://docs.docker.com/compose/install/) e o Make instalados. 


##  🏁 Uso <a name="usage"></a>

Essas instruções fornecerão acesso ao banco funcionando em sua máquina local para fins de desenvolvimento, execução de pesquisas ou outros meios para promover o controle social.

Os passos para a restauração e utilização do banco de dados são elecandos abaixo:

1. Após ter clonado e entrado no repositório, construa a imagem do docker.

```shell
sudo make build
```
2. Agora baixe o backup do GeoPB e execute o container do docker.

```shell
# baixe os dados
sudo make fetch-geopb-backup
# execute o container
sudo make up
```
3. Entre no container e execute o .sql para criar um novo banco.

```shell
# entre no container
sudo make enter-container

# crie um novo banco
psql -U postgres -h 127.0.0.1 < /sql/create_db.sql
```

4. Restaure o banco.
```shell
# restaure o banco 
pg_restore -U postgres -d geopb_db --if-exists --clean /backup/TCEPB_geopb_export.backup

# agora saia do container (ctrl+d)
```
5. Verifique se a restauração funcionou recuperando as tabelas presente no banco.

```shell
# entre no banco
sudo make geopb-shell

#verifique as tabelas presentes no banco 
\dt
```

6. Abaixo está um exemplo de como utilizar esses dados via R.
```R
library(dplyr)
library(odbc)

POSTGRES_HOST="localhost"
POSTGRES_DB="geopb_db"
POSTGRES_USER="postgres"
POSTGRES_PASSWORD="secret123456"
POSTGRES_PORT=7658

db_con <- NULL
db_con <- DBI::dbConnect(RPostgres::Postgres(),
                          dbname = POSTGRES_DB, 
                          host = POSTGRES_HOST, 
                          port = POSTGRES_PORT,
                          user = POSTGRES_USER,
                          password = POSTGRES_PASSWORD)

obras <- dplyr::tbl(db_con, sql('SELECT * FROM t_obra')) %>% dplyr::collect(n = Inf)
```




7. Por fim, para **interromper** a execução do container execute:
```shell
sudo make stop
```


## ⛏️ Ferramentas <a name = "built_using"></a>

- [Docker](https://www.docker.com/) - Containers
- [PosgresSQL](https://www.postgresql.org/) - Sistema gerenciador de Banco de dados relacional
