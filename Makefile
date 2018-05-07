SHELL += -eu

BLUE	:= \033[0;34m
GREEN	:= \033[0;32m
RED   := \033[0;31m
NC    := \033[0m
LAMBDA_VERSION = 0.1


plan: init 
		terraform plan -out terraform.plan

init:
		terraform init

create-ssl:
		cd ssl && cfssl gencert -initca ca-csr.json | cfssljson -bare ca -

service-account:
		cd ssl && openssl genrsa -out service-account-key.pem 4096

certficate-upload: init plan
		terraform apply -auto-approve -target=module.s3_pki \
									 -target=aws_s3_bucket_object.ca_pem \
									 -target=aws_s3_bucket_object.ca_key_pem \
									 -target=aws_s3_bucket_object.ca_csr \
									 -target=aws_s3_bucket_object.ca_csr_json \
									 -target=aws_s3_bucket_object.ca_config_json \
									 -target=aws_s3_bucket_object.service_account_key_pem

lambda-src-download:
	curl -fsSL  -o modules/lambda/files/src.tar.gz https://github.com/recart/lambda-dns-service/archive/$(LAMBDA_VERSION).tar.gz

lambda-unarchive:
	tar xvf modules/lambda/files/src.tar.gz -C modules/lambda/files

lambda-install:
	cd modules/lambda/files/lambda-dns-service-$(LAMBDA_VERSION) && make all

lambda: lambda-src-download lambda-unarchive lambda-install

apply: plan
		terraform apply -auto-approve terraform.plan

ssl: create-ssl service-account certficate-upload

first: init lambda ssl plan apply
