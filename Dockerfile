FROM n8nio/runners:1.121.0

# Copiar la lista de librerías extras y el archivo de configuración
COPY extras.txt /tmp/extras.txt
COPY n8n-task-runners.json /etc/n8n-task-runners.json

USER root

# Instalar las librerías dentro del entorno virtual del runner
RUN set -e; \
    VENV_PYTHON="/opt/runners/task-runner-python/.venv/bin/python"; \
    if [ -x "$VENV_PYTHON" ]; then \
        PY_BIN="$VENV_PYTHON"; \
    else \
        PY_BIN="$(command -v python3)"; \
    fi; \
    echo "Usando Python: $PY_BIN"; \
    "$PY_BIN" -m ensurepip --upgrade; \
    "$PY_BIN" -m pip install --no-cache-dir -r /tmp/extras.txt

USER runner

# Se elimina cualquier creación manual de directorios y el ENTRYPOINT,
# la imagen oficial ya sabe cómo iniciarse por sí sola.