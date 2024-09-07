FROM python:3.9-alpine@sha256:a659d6689733f9d9ed37771665bd42036168f5ca6fc2ef1f029ebeb1e07f7cfe

# Housekeeping:
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV PATH="/usr/src/app/scripts:${PATH}"

RUN pip install --upgrade pip

COPY requirements.txt .

RUN apk add --update --no-cache --virtual .tmp-build-deps \
      gcc libc-dev linux-headers build-base musl-dev zlib zlib-dev libffi-dev
RUN pip install -r requirements.txt
RUN apk del .tmp-build-deps

WORKDIR /usr/src/app
COPY main.py .
COPY scripts/ ./scripts/

RUN adduser -D user
RUN chown -R user:user /usr/src/app/
RUN chmod -R 755 /usr/src/app/

USER user

CMD ["/bin/sh", "/usr/src/app/scripts/entrypoint.sh"]

