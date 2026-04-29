# nvoip-shell

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

## Documentação oficial

- https://nvoip.docs.apiary.io/
- https://www.nvoip.com.br/api
