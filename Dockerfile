FROM python:3.12
COPY --from=ghcr.io/astral-sh/uv /uv /usr/bin/uv
ENV UV_SYSTEM_PYTHON=1

WORKDIR /content

RUN git config --global credential.helper store

RUN --mount=type=cache,target=/root/.cache/uv \
    UV_LINK_MODE=copy \
    uv pip install \
      git+https://github.com/uglabs/colabtools.git@a065bcd \
      httplib2 \
      jupyter \
      jupyter_contrib_nbextensions \
      numpy \
      pandas \
      pillow

VOLUME /root/.cache/uv /root/.cache/pip /content /root/.cache/huggingface

EXPOSE 9876
CMD [ \
  "uv", \
  "run", \
  "jupyter", \
  "lab", \
  "--NotebookApp.allow_origin='https://colab.research.google.com'", \
  "--port=9876", \
  "--allow-root", \
  "--NotebookApp.port_retries=0", \
  "--ServerApp.ip", \
  "0.0.0.0"\
]
