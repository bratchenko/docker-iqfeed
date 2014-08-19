Dockerized IQFeed client
=======================

It stores login/password in Windows registry within container for now, so you need to create your own wine root for this to work.

I recommend performing following steps on Ubuntu 14.04 machine. You can set up one in 5 minutes using, for example, [http://digitalocean.com].

Idea and Makefile are borrowed from [https://github.com/macdice/iqfeed-debian].

Building docker image
---------------------

1. Install wine

```
apt-get install -y software-properties-common
add-apt-repository -y ppa:ubuntu-wine/ppa
apt-get update
apt-get -y install wine1.7
```

2. You need a GUI for this to work, so if you're doing it on server, [install vncserver](http://www.howtoforge.com/how-to-install-vnc-server-on-ubuntu-14.04).

3. Run `make fetch` in this folder to download IQFeed Client installation file. You can change IQFeed Client version at the top of Makefile.

4. In GUI, run `make install`. Don't change default settings.

5. In GUI, run `make launch`. Enter your username and password, check "Save Login And Password" and "Automatically Connect" checkboxes.

6. You can exit GUI now.

7. Edit iqfeed.conf and enter your desired iqfeed version and product name.

8. Install docker, if you haven't before: `curl -sSL https://get.docker.io/ubuntu/ | sudo sh`

9. In the current folder, run `docker build -t iqfeed .`.

10. Your image is ready by the name `iqfeed`. You can run it now on any machine: `docker run --net="host" iqfeed`. We use `--net="host"` because IQFeed is listening only to localhost and it's the most convenient way to map it to the host machine. You can use some kind of proxy within docker container (or outside it) to make IQFeed to be available ouside host machine.
