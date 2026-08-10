#!/bin/bash

#Nvoip - SMS

#Copyright (C) 2020 Nvoip Plataforma Telefonia Ltda
#Leandro Campos <https://www.linkedin.com/in/leandro-campos/>
#License https://www.gnu.org/licenses/gpl-3.0.html

#This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by #the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

#This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

#You should have received a copy of the GNU General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.

#Nome do arquivo onde vai conter as urls para fazer o download.
File="cdr.txt"
wget -p -i  $File
