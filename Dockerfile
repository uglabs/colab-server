FROM python:3.12

RUN pip install uv

RUN uv venv --seed

RUN uv pip install jupyter

EXPOSE 9876
CMD ["uv", "run", "jupyter", "notebook", "--NotebookApp.allow_origin='https://colab.research.google.com'", "--port=9876", "--NotebookApp.port_retries=0", "--allow-root", "--ServerApp.ip", "0.0.0.0"]
