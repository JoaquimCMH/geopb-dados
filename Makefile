.DEFAULT_GOAL : help
help:
	@echo "\nGeoPB - Serviço de dados"
	@echo "Este repositório fornece meios, através do docker, para facilitar o uso dos dados" 
	@echo "abertos de obras oriundos do Tribunal de Contas do estado da Paraíba. Com ele é"
	@echo "possível restaurar o banco PostgreSQL do GeoPB com todos os pacotes necessários"
	@echo "para o funcionamento da aplicação, como dependências e bibliotecas."
	@echo ""
	@echo "COMO USAR:\n\t'make <comando>'"
	@echo ""
	@echo "\t-----------------------------------------------------------------------------------------"
	@echo "\tcomando \t\t\tDescrição"
	@echo "\t-----------------------------------------------------------------------------------------"
	@echo "\thelp \t\t\t\tMostra esta mensagem de ajuda"
	@echo "\t-----------------------------------------------------------------------------------------"
	@echo "\tbuild \t\t\t\tRealiza o build das imagens com as dependências necessária"
	@echo "\t\t\t\t\tpara restaurar o banco de dados."
	@echo "\t-----------------------------------------------------------------------------------------"
	@echo "\tup \t\t\t\tCria e inicia os containers."
	@echo "\t-----------------------------------------------------------------------------------------"
	@echo "\tstop \t\t\t\tPara todos os serviços."
	@echo "\t-----------------------------------------------------------------------------------------"
	@echo "\enter-container \t\t\t\tEntra no container no docker."
	@echo "\t-----------------------------------------------------------------------------------------"
	@echo "\fetch-geopb-backup \t\t\t\tBaixa o backup do GeoPB(PostgreSQL)
	@echo "\t-----------------------------------------------------------------------------------------"
	@echo "\geopb-shell \t\t\t\tEntra no banco do GeoPB
	@echo "\t-----------------------------------------------------------------------------------------"
	@echo ""

.PHONY: help
build:
	docker-compose build
.PHONY: build
up:
	docker-compose up -d
.PHONY: up
stop:
	docker-compose stop
.PHONY: stop
enter-container:
	docker exec -it postgres-geopb bash
.PHONY: enter-container
fetch-geopb-backup:
	wget -P /backup https://dados.tce.pb.gov.br/TCEPB_geopb_export.backup 
.PHONY: fetch-geopb-backup
geopb-shell:
	docker exec -it postgres-geopb psql -U postgres -d geopb_db 
.PHONY: geopb-shell