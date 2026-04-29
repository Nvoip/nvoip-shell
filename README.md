# nvoip-shell

Conjunto de scripts Shell para Linux e automacoes simples usando a API v2 da Nvoip.

## O que tem aqui

- `lib/nvoip.sh`: funcoes reutilizaveis para OAuth, SMS, chamadas, saldo e torpedo de voz
- `Scripts/send_sms_nvoip.sh`: envio simples de SMS
- `Scripts/send_torpedovoz_nvoip.sh`: envio simples de torpedo de voz
- `examples/`: exemplos prontos de saldo, SMS e chamadas
- `Scripts/download-audio-nvoip.sh`: utilitario legado para baixar links de gravacao

## Dependencias

- `curl`
- `sed`
- shell POSIX

## Configuracao

```bash
cp .env.example .env
```

Ou exporte as variaveis direto no shell:

```bash
export NVOIP_NUMBERSIP="seu_numbersip"
export NVOIP_USER_TOKEN="seu_user_token"
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

Criar chamada:

```bash
sh examples/create-call.sh
```

## Observacoes

- `NVOIP_ACCESS_TOKEN` e opcional. Se nao for informado, os exemplos geram um token OAuth automaticamente.
- para torpedo de voz, o endpoint atual usa `/v2/torpedo/voice`
- para clientes Linux que so querem disparar recursos da API sem SDK, este repositorio deve ser o principal ponto de entrada

## Documentacao oficial

- https://nvoip.docs.apiary.io/
- https://www.nvoip.com.br/api
