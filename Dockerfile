FROM rocker/r-ver:4.3.1

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

RUN wget https://github.com/quarto-dev/quarto-cli/releases/download/v1.3.433/quarto-1.3.433-linux-amd64.deb -O ~/quarto.deb

RUN apt-get install --yes ~/quarto.deb

RUN rm ~/quarto.deb

RUN mkdir /root/projects/

RUN echo 'options(httpgd.host = "0.0.0.0", httpgd.port = 8888, httpgd.token = "aaaaaaaa")' >> /root/.Rprofile

RUN echo 'options(renv.config.cache.symlinks = FALSE)' >> /root/.Rprofile

RUN echo 'options(shiny.host = "0.0.0.0", shiny.port = 8888)' >> /root/.Rprofile

RUN echo 'options(servr.host = "0.0.0.0", servr.port = 8888)' >> /root/.Rprofile

RUN echo 'options(repos = c(REPO_NAME = "https://packagemanager.posit.co/cran/__linux__/jammy/2023-06-30"))' >> /root/.Rprofile

RUN R -e "install.packages(c('flextable', 'quarto', 'remotes', 'tinytex', 'tidyverse', 'arrow', 'chronicler', 'janitor', 'targets', 'tarchetypes', 'openxlsx', 'shiny', 'flexdashboard', 'data.table', 'httpgd', 'blogdown', 'bookdown', 'ggridges', 'skimr', 'rang', 'groundhog'))" 

RUN R -e "install.packages(c('sandwich', 'VGAM', 'jsonlite', 'AER', 'plyr', 'dplyr', 'quantreg', 'geepack', 'MCMCpack', 'maxLik', 'Amelia', 'MatchIt', 'survey'))"

RUN R -e "install.packages('http://cran.r-project.org/src/contrib/Archive/Zelig/Zelig_5.1.6.tar.gz', repos=NULL, type='source')"

RUN R -e "install.packages('http://cran.r-project.org/src/contrib/Archive/ZeligChoice/ZeligChoice_0.9-6.tar.gz', repos=NULL, type='source')"

RUN R -e "remotes::install_github('devOpifex/g2r')"

RUN R -e "tinytex::install_tinytex()"

# This old release of hugo is what I need
RUN R -e "blogdown::install_hugo(version = '0.25.1')"

EXPOSE 8888
