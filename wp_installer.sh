#!/bin/bash

echo " --------------------------------------------------- "
echo " --- Instalação automática do WordPress - WP CLi --- "
echo " --------------------------------------------------- "

echo -e "Criar diretório de instalação"
read wp_dir_installation

echo "Criando diretório..."
sudo mkdir $wp_dir_installation
sudo chmod 777 -R $wp_dir_installation
cd $wp_dir_installation

echo "Diretório criado com sucesso!"

echo -e "\nIdioma"
read wp_language

echo -e "\nIniciando o download do WordPress..."
wp core download --locale="$wp_language"

echo -e "\nBanco de dados"
read wp_database

echo -e "\nUsuário do Banco de Dados"
read wp_db_user

echo -e "\nSenha do Banco de Dados"
read wp_db_password

echo -e "\nConfigurando o WordPress..."

if [$wp_db_password == ""]; then
	wp core config --dbname=$wp_database --dbuser=$wp_db_user
else
	wp core config --dbname=$wp_database --dbuser=$wp_db_user --dbpass=$wp_db_password
fi

echo "Criando o Banco de Dados..."
wp db create

echo "Configuração realizada com sucesso!"

echo -e "\nTítulo do Site"
read wp_site_title

echo -e "\nURL do Site"
read wp_site_url

echo -e "\nAdministrador WordPress"
read wp_admin_user

echo -e "\nSenha do Administrador"
read wp_admin_password

echo -e "\nE-mail do Administrador"
read wp_admin_email

echo -e "\nInstalando o WordPress..."

wp core install --admin_user=$wp_admin_user --admin_password=$wp_admin_password --admin_email=$wp_admin_email --url=$wp_site_url --title="$wp_site_title"

echo -e "\nWordPress instalado com sucesso em: $wp_site_url"