# nvoip-shell
Scripts e bibliotecas para a linguagem Shell para uso com a API da Nvoip.

## Intruções
- Para usar os scripts, é necessário ter uma conta e um token válido na Nvoip. Você pode criar sua conta gratuitamente em https://www.nvoip.com.br
- Sinta-se livre para criar e contribuir com os códigos deste repositório. Também fique a vontade para reportar bugs relacionados ao uso da API com a linguagem Shell Scripts.
- Acesse https://www.nvoip.com.br/api para acessar a documentação da nossa API.

## Scripts by Nvoip:
### Disparo de SMS Shell Script - send_sms_nvoip.sh
Este script irá disparar um SMS quando for acionado.
Como usar: 

1. Aplique valores às variáveis de ambiente (opcional):

```bash
$ export NVOIP_TOKEN_AUTH=token
$ export NVOIP_CELULAR=numero-do-celular
$ export NVOIP_MSG=mensagem
```

2. Execute o script com o comando:

``` bash
$ sh send_sms_nvoip.sh
```
ou, (caso não tenha seguido o passo 1):

```bash
$ NVOIP_TOKEN_AUTH=token NVOIP_CELULAR=numero-do-celular NVOIP_MSG=mensagem sh send_sms_nvoip.sh
```

3. Aguarde uns instantes que você irá receber o SMS.

### Disparo de Torpedo de Voz Shell Script - send_torpedovoz_nvoip.sh
Este script irá disparar uma ligação de voz lendo o problema ocasionado através de TTS.

Como usar: 

1. Aplique valores às variáveis de ambiente (opcional):

```bash
$ export NVOIP_TOKEN_AUTH=token
$ export NVOIP_CALLER=numero
$ export NVOIP_CALLED=numero
$ export NVOIP_AUDIO=caminho-arquivo-de-audio
```

2. Execute o script com o comando:

```bash
$ sh send_torpedovoz_nvoip.sh
```

ou, (caso não tenha seguido o passo 1):

```bash
$ NVOIP_TOKEN_AUTH=token NVOIP_CALLER=numero NVOIP_CALLED=numero NVOIP_AUDIO=caminho-arquivo-de-audio sh send_torpedovoz_nvoip.sh
```

3. Aguarde alguns segundos que você irá receber a ligação.

# English Version
Shell language scripts and libraries for use with the Nvoip API.

## Instructions
- To use the scripts, you must have a valid Nvoip account and token. You can create your account for free at https://www.nvoip.com.br
- Feel free to create and contribute code from this repository. Also feel free to report bugs related to the use of the API with the Shell Script Language.
- Visit https://www.nvoip.com.br/api to access our API documentation.

## Scripts by Nvoip:
### SMS Shell Script Trigger send_sms_nvoip.sh
This script will trigger an SMS when it fires.
How to use it:

1. Apply values to environment variables (optional):

```bash
$ export NVOIP_TOKEN_AUTH=token
$ export NVOIP_CELULAR=number
$ export NVOIP_MSG=message
```

2. Run the script with the command:

```bash
$ sh send_sms_nvoip.sh
```

or, (if you do not follow the step 1):

```bash
$ NVOIP_TOKEN_AUTH=token NVOIP_CELULAR=number NVOIP_MSG=message sh send_sms_nvoip.sh
```

3. Wait a moment you will receive the SMS.

### SMS Shell Script Trigger send_torpedovoz_nvoip.sh
This script will trigger a voice call reading the problem caused through TTS.
How to use it:

1. Apply values to environment variables (optional):

```bash
$ export NVOIP_TOKEN_AUTH=token
$ export NVOIP_CALLER=number
$ export NVOIP_CALLED=number
$ export NVOIP_AUDIO=path-to-audio-file
```

2. Run the script with the command:

```bash
$ sh send_torpedovoz_nvoip.sh
```

or, (if you do not follow the step 1):

```bash
$ NVOIP_TOKEN_AUTH=token NVOIP_CALLER=number NVOIP_CALLED=number NVOIP_AUDIO=path-to-audio-file sh send_torpedovoz_nvoip.sh
```

3. Ready. You will now receive the Voice Call Message.
