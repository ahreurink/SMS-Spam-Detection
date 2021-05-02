FROM python:3.7.10-slim

WORKDIR /root/
COPY requirements.txt .

RUN mkdir output &&\
	python -m pip install --upgrade pip &&\
	pip install -r requirements.txt

COPY smsspamcollection/ smsspamcollection/
COPY src/ src/

RUN	python src/read_data.py &&\
	python src/text_preprocessing.py &&\
	python src/text_classification.py

EXPOSE 8080

CMD ["python", "src/serve_model.py"]
