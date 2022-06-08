#!/bin/bash

set -e

#Nvoip - Torpedo de Voz Shell Script

#Copyright (C) 2020 Nvoip Plataforma Telefonia Ltda
#Leandro Campos <https://www.linkedin.com/in/leandro-campos/>
#License https://www.gnu.org/licenses/gpl-3.0.html

#This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by #the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

#This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

#You should have received a copy of the GNU General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.

###Inicio do Script###

# $TOKEN_AUTH
# Seu Token da Nvoip. Acesse https://www.nvoip.com.br, crie sua para ter acesso ao seu Token.
# English: Your Nvoip Token. Visit https://www.nvoip.com.br, create yours to have access to your Token.

# $NVOIP_CALLER
# O número do seu usuário(ramal) na Nvoip. O mesmo não precisa estar online.
# English: Your Nvoip username (extension). It does not have to be online.

# $NVOIP_CALLED
# O telefone que irá receber a ligação.
# English: Phone will receive the voice call.

# $NVOIP_AUDIO
# Texto que irá ser lido ou URL de arquivo MP3 que será tocado. A URL deve estar pública na internet e quando acessada via navegador, deverá abrir o player e começar a tocar.
# English: Text to be read or MP3 file URL to be played. The URL must be public on the internet and when accessed via a browser, should open the player and start playing.

curl --include \
     --request POST \
     --header "Content-Type: application/json" \
     --header "token_auth: $NVOIP_TOKEN_AUTH" \
     --data-binary "{
    \"caller\":\"$NVOIP_CALLER\",
    \"called\":\"$NVOIP_CALLED\",
    \"audio\":\"$NVOIP_AUDIO\"
}" \
'https://api.nvoip.com.br/v1/torpedovoz'
