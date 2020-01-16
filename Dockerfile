#Download base image android
FROM thyrlian/android-sdk:latest

ENV RUBY_VER ruby-2.4.1
ENV TWINE_VER 1.0.6


RUN apt-get install gnupg2 -y
RUN apt-get install curl -y

RUN mkdir ~/.gnupg
RUN echo "disable-ipv6" >> ~/.gnupg/dirmngr.conf

# RUBY INSTALLATION START
RUN gpg2 --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB && \
    curl -L https://get.rvm.io | bash -s stable && \
    /bin/bash -l -c "rvm requirements;" && \
    /bin/bash -c "source /etc/profile.d/rvm.sh"

RUN /bin/bash -l -c "rvm autolibs disable;" && \
    /bin/bash -l -c "rvm install ${RUBY_VER} --debug" && \
    /bin/bash -l -c "rvm use --default ${RUBY_VER} && \
    gem install bundler"

# RUBY INSTALLATION END

RUN /bin/bash -l -c "rvm use --default ${RUBY_VER} && gem install twine -v ${TWINE_VER}"