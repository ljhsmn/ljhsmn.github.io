FROM ubuntu:latest
LABEL authors="ljhsmn"
RUN useradd -m page && usermod -a -G root page \
    && su page \
    && cp -a /etc/apt/sources.list /etc/apt/sources.list.bak \
    && sed -i "s@http://.*archive.ubuntu.com@http://repo.huaweicloud.com@g" /etc/apt/sources.list \
    && sed -i "s@http://.*security.ubuntu.com@http://repo.huaweicloud.com@g" /etc/apt/sources.list \
    && echo '#InstallRubyGemsto~/gems' >> ~/.bashrc \
    && echo 'export GEM_HOME="$HOME/gems"' >> ~/.bashrc \
    && echo 'export PATH="$HOME/gems/bin:$PATH"' >> ~/.bashrc \
    && apt-get update \
    && apt-get install ruby-full build-essential zlib1g-dev -y && mkdir "githubPage" \
    && gem sources --add https://mirrors.tuna.tsinghua.edu.cn/rubygems/ --remove https://rubygems.org/ \
    && gem install jekyll bundler \
    && bundle config mirror.https://rubygems.org https://mirrors.tuna.tsinghua.edu.cn/rubygems
RUN chmod 775 -R /githubPage &&  chmod -R 775 /var/lib/gems/;

#su page -c "cd /githubPage && bundle install  &&  jekyll serve --host host.docker.internal"
