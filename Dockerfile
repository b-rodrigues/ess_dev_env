FROM rocker/r-ver:4.4.1

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    gpg-agent software-properties-common

RUN add-apt-repository ppa:ubuntuhandbook1/emacs

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    git \
    wget \
    curl \
    emacs \
    pip

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
   pandoc \
   build-essential \
   libssl-dev \
   zlib1g-dev \
   libbz2-dev \
   libreadline-dev \
   libsqlite3-dev \
   git \
   libncursesw5-dev \
   xz-utils \
   tk-dev \
   libxml2-dev \
   libxmlsec1-dev \
   libffi-dev \
   liblzma-dev

RUN wget https://github.com/quarto-dev/quarto-cli/releases/download/v1.5.55/quarto-1.5.55-linux-amd64.deb -O ~/quarto.deb

RUN apt-get install --yes ~/quarto.deb

RUN rm ~/quarto.deb

RUN mkdir /root/projects/


# Install pyenv
RUN curl https://pyenv.run | bash

# Set environment variables for pyenv
ENV PATH="/root/.pyenv/bin:/root/.pyenv/shims:/root/.pyenv/versions/3.12.0/bin:$PATH"
ENV PYENV_ROOT="/root/.pyenv"

# Install Python 3.10
RUN pyenv install 3.10.14
RUN pyenv global 3.10.14

# Verify installation
RUN python --version

# Install the polars package
RUN pip install octopize.avatar polars

RUN echo 'options(repos = c(REPO_NAME = "https://packagemanager.posit.co/cran/__linux__/jammy/2024-07-22"))' >> /root/.Rprofile

RUN R -e "install.packages(c('quarto', 'tinytex', 'tidyverse', 'reticulate', 'arrow', 'chronicler', 'janitor', 'targets', 'tarchetypes', 'openxlsx', 'data.table', 'skimr', 'plotcli'))" 

#RUN R -e "install.packages(c('sandwich', 'VGAM', 'jsonlite', 'AER', 'plyr', 'dplyr', 'quantreg', 'geepack', 'MCMCpack', 'maxLik', 'Amelia', 'MatchIt', 'survey'))"

#RUN R -e "install.packages('http://cran.r-project.org/src/contrib/Archive/Zelig/Zelig_5.1.6.tar.gz', repos=NULL, type='source')"

#RUN R -e "install.packages('http://cran.r-project.org/src/contrib/Archive/ZeligChoice/ZeligChoice_0.9-6.tar.gz', repos=NULL, type='source')"

#RUN R -e "remotes::install_github('devOpifex/g2r')"

RUN R -e "tinytex::install_tinytex()"

# This old release of hugo is what I need
#RUN R -e "blogdown::install_hugo(version = '0.25.1')"

RUN emacs --daemon

EXPOSE 9999
