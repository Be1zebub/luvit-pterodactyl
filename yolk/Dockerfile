#
# Copyright (c) 2022 incredible-gmod.ru
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#

# Базовый образ
FROM        --platform=$TARGETOS/$TARGETARCH debian:bookworm-slim

# Метаданные
LABEL 		author="Be1zebub" maintainer="beelzebub@incredible-gmod.ru"
LABEL 		org.opencontainers.image.licenses=MIT

# Неинтерактивная настройка окружения
ENV         DEBIAN_FRONTEND=noninteractive

# Обновление списка пакетов и установка основных пакетов
RUN      	apt update && apt upgrade -y \
         	&& apt -y --no-install-recommends install ca-certificates curl git unzip zip tar jq wget libtool iproute2 net-tools netcat \
		 	&& apt install -y locales

# Установка дополнительных зависимостей для функций голосового чата Discordia
RUN 		apt install -y sqlite3 libsqlite3-dev libopus-dev libsodium-dev ffmpeg

# Настройка локали
RUN 		update-locale lang=en_US.UTF-8 && \
    		dpkg-reconfigure --frontend noninteractive locales

# Создание пользователя и установка рабочего каталога
RUN 		useradd -m -d /home/container container

# Установка переменных среды и рабочего каталога пользователя
USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

# Копирование скрипта входа и установка команды по умолчанию
COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]
