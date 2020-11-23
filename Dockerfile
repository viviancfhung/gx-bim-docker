FROM continuumio/miniconda3

WORKDIR /home
RUN apt-get update; \
    apt-get -y install vim; \
    apt-get install -y git-core curl build-essential openssl libssl-dev python; \
    apt -y install nodejs npm;

WORKDIR /home
RUN git clone https://gitlab+deploy-token-11095:JjXvrdtsDKTp6Dx_Vpzu@gitlab.com/hubert.thieriot1/gx-bim-360.git;

WORKDIR /home/gx-bim-360
RUN git checkout test; \
    su; \
    conda update -n base -c defaults conda; \
    conda create --name gxbim pip
    
SHELL ["conda", "run", "-n", "gxbim", "/bin/bash", "-c"]
RUN pip install -r requirements.txt; \
    npm install; \
    mv .env.template .env

EXPOSE 8080

CMD ["python" "manage.py". "runserver" "--settings=settings.development"]

CMD [ "npm", "run", "serve" ]