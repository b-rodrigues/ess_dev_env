FROM rocker/r-ver:4.3

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    gpg-agent software-properties-common

RUN add-apt-repository ppa:kelleyk/emacs

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    git \
    wget \
    emacs28-nox

RUN git clone -b develop https://github.com/syl20bnr/spacemacs ~/.emacs.d

RUN wget https://raw.githubusercontent.com/b-rodrigues/dotfiles/master/dotfiles/.spacemacs -O ~/.spacemacs

RUN emacs --daemon

RUN apt-get update \
   && apt-get install -y --no-install-recommends \
   aspell \
   aspell-en \
   aspell-fr \
   aspell-pt-pt \
   libfontconfig1-dev \
   libglpk-dev \
   libxml2-dev \
   libcairo2-dev \
   libgit2-dev \
   default-libmysqlclient-dev \
   libpq-dev \
   libsasl2-dev \
   libsqlite3-dev \
   libssh2-1-dev \
   libxtst6 \
   libcurl4-openssl-dev \
   libharfbuzz-dev \
   libfribidi-dev \
   libfreetype6-dev \
   libpng-dev \
   libtiff5-dev \
   libjpeg-dev \
   libxt-dev \
   unixodbc-dev \
   pandoc

RUN wget https://github.com/quarto-dev/quarto-cli/releases/download/v1.3.340/quarto-1.3.340-linux-amd64.deb -O ~/quarto.deb

RUN apt-get install --yes ~/quarto.deb

RUN rm ~/quarto.deb

RUN mkdir /root/projects/

RUN echo 'options(httpgd.host = "0.0.0.0", httpgd.port = 8888, httpgd.token = "aaaaaaaa")' >> /root/.Rprofile

RUN echo 'options(repos = c(REPO_NAME = "https://packagemanager.rstudio.com/cran/__linux__/jammy/2023-04-28"))' >> /root/.Rprofile

RUN R -e "install.packages(c('quarto', 'remotes', 'tinytex', 'tidyverse', 'arrow', 'chronicler', 'janitor', 'targets', 'openxlsx', 'shiny', 'httpgd', 'blogdown', 'bookdown'))" 

RUN R -e "tinytex::install_tinytex()"

RUN R -e "blogdown::install_hugo()"

RUN echo 'httpgd::hgd()' >> /root/.Rprofile

EXPOSE 8888

