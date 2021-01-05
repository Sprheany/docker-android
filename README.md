# docker-android

一个基于 [Docker](https://www.docker.com/) 的 [Android](http://www.android.com/) 编译环境镜像，已安装了JDK，Android SDK，可用于持续集成。

[![Build Status](https://travis-ci.org/Sprheany/docker-android.svg?branch=master)](https://travis-ci.org/Sprheany/docker-android)

## 如何使用

该镜像已经发布到 Docker Hub 的公共仓库中，直接使用 [sprheany/docker-android](https://hub.docker.com/r/sprheany/docker-android/) 镜像即可。

Dockerfile
```
FROM sprheany/docker-android
```

在项目根目录创建一个 `.yml` 文件来开启你的持续集成服务。
```yml
image: sprheany/docker-android

script:
    - ./gradlew build
```

## 已安装环境
- [x] Python 3.6.8
- [x] OpenJDK 8
- [x] Android SDK Tools
- [x] Android SDK Platform-tools
