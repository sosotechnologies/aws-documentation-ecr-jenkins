FROM python:alpine3.17

COPY ./sosotech-docs/ /sosotech-docs/

RUN pip install mkdocs

RUN mkdocs new sosotech-docs

EXPOSE 8080

WORKDIR /sosotech-docs/

ENTRYPOINT ["mkdocs"]
#CMD [ "python", "server.py" ]
CMD ["serve", "--dev-addr=0.0.0.0:8080"]
#CMD ["serve", "mkdocs.yaml"]
