# nvoip-shell

[![CI](https://github.com/Nvoip/nvoip-shell/actions/workflows/ci.yml/badge.svg)](https://github.com/Nvoip/nvoip-shell/actions/workflows/ci.yml) [![Homebrew](https://img.shields.io/badge/Homebrew-Nvoip%2Ftap-FBB040?style=flat-square)](https://github.com/Nvoip/homebrew-tap) [![GitHub tag](https://img.shields.io/github/v/tag/Nvoip/nvoip-shell?style=flat-square)](https://github.com/Nvoip/nvoip-shell/releases) [![Nvoip](https://img.shields.io/badge/Nvoip-site-00A3E0?style=flat-square)](https://www.nvoip.com.br/) [![API v2](https://img.shields.io/badge/API-v2-1F6FEB?style=flat-square)](https://www.nvoip.com.br/api/) [![Docs](https://img.shields.io/badge/docs-Apiary-6A737D?style=flat-square)](https://nvoip.docs.apiary.io/) [![Postman](https://img.shields.io/badge/Postman-workspace-FF6C37?style=flat-square)](https://nvoip-api.postman.co/workspace/e671d01f-168a-4c38-8d0e-c217229dd61a/team-quickstart) [![Stack](https://img.shields.io/badge/stack-Shell-4EAA25?style=flat-square)](https://github.com/Nvoip/nvoip-api-examples) [![License: GPL-3.0](https://img.shields.io/badge/license-GPL--3.0-blue?style=flat-square)](LICENSE)

Scripts oficiais da [Nvoip](https://www.nvoip.com.br/) para integrar a API v2 com OAuth, chamadas, OTP, WhatsApp, SMS, saldo e voz em Linux e Shell.

## O que tem aqui

- `lib/nvoip.sh`: funções reutilizáveis para OAuth, saldo, SMS, chamadas, OTP, WhatsApp e torpedo de voz
- `Scripts/send_sms_nvoip.sh`: envio simples de SMS
- `Scripts/send_torpedovoz_nvoip.sh`: envio simples de torpedo de voz
- `examples/`: exemplos prontos de autenticação, saldo, SMS, chamadas, OTP e WhatsApp
- `Scripts/download-audio-nvoip.sh`: utilitário legado para baixar links de gravação

## Dependências

- `curl`
- `sed`
- shell POSIX

## Configuração

```bash
cp .env.example .env
```

Ou exporte as variáveis direto no shell:

```bash
export NVOIP_NUMBERSIP="seu_numbersip"
export NVOIP_USER_TOKEN="seu_user_token"
export NVOIP_OAUTH_CLIENT_ID="seu_client_id"
export NVOIP_OAUTH_CLIENT_SECRET="seu_client_secret"
export NVOIP_CALLER="1049"
export NVOIP_TARGET_NUMBER="11999999999"
export NVOIP_SMS_MESSAGE="Mensagem de teste Nvoip"
```

## Exemplos

Enviar SMS:

```bash
sh examples/send-sms.sh
```

Consultar saldo:

```bash
sh examples/get-balance.sh
```

Gerar `access_token`:

```bash
sh examples/create-access-token.sh
```

Criar chamada:

```bash
sh examples/create-call.sh
```

Enviar OTP:

```bash
sh examples/send-otp.sh
```

Validar OTP:

```bash
sh examples/check-otp.sh
```

Listar templates de WhatsApp:

```bash
sh examples/list-whatsapp-templates.sh
```

Enviar template de WhatsApp:

```bash
sh examples/send-whatsapp-template.sh
```

## Observações

- `NVOIP_ACCESS_TOKEN` é opcional. Se não for informado, os exemplos geram um token OAuth automaticamente.
- para torpedo de voz, o endpoint atual usa `/v2/torpedo/voice`
- para clientes Linux que só querem disparar recursos da API sem SDK, este repositório deve ser o principal ponto de entrada
- para fluxo de popup de telefone + código, use em conjunto o repositório `nvoip-web-sdk`

## Links oficiais

- [Site da Nvoip](https://www.nvoip.com.br/)
- [Documentação da API](https://nvoip.docs.apiary.io/)
- [Página da API](https://www.nvoip.com.br/api/)
- [Workspace Postman](https://nvoip-api.postman.co/workspace/e671d01f-168a-4c38-8d0e-c217229dd61a/team-quickstart)
- [Hub de exemplos](https://github.com/Nvoip/nvoip-api-examples)
