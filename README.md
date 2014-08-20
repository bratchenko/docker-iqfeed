Dockerized IQFeed client
=======================

Usage
-----

```
docker run -e LOGIN=<your iqfeed login> -e PASSWORD=<your iqfeed password> -p 5009:5010 -p 9100:9101 bratchenko/iqfeed
```

You should see out put like this:
```
Connecting to port  9300
Disconnected. Reconnecting in 1 second.
Connecting to port  9300
Disconnected. Reconnecting in 1 second.
fixme:thread:GetThreadPreferredUILanguages 52, 0x32fac4, 0x32fb34 0x32facc
fixme:heap:HeapSetInformation (nil) 1 (nil) 0
fixme:thread:GetThreadPreferredUILanguages 52, 0x32f880, 0x32f8f0 0x32f888
```

That's totally ok.

Wait until you start seeing log lines that have word "Connected" in them. They should look like this:

```
S,STATS,66.112.148.223,60002,500,0,1,0,5,0,Aug 20 2:42PM,Aug 20 2:42PM,Connected,5.1.1.0,416828,0.55,0.02,0.03,3.94,0.11,0.18,
```

Here you go, now you should be able to connect to ports 5009 or 9100 to the current machine as if you're connecting to an IQFeed client.

If you don't start seeing "Connected" lines in about 1 minute, then you probably entered login or password incorrectly. Unfortunately, IQFeed doesn't say anything about it, just doesn't connect.

Details
-------

This image runs an IQFeed client (version 5.1.1.0) using Ubuntu 14.04 and wine.

It exposes IQFeed ports 5009 and 9100 as 5010 and 9101 correspondingly. Port change is because IQFeed listens on localhost and proxy embeded into container translates those ports to 5010 and 9101.

Image accepts following environment variables:

* LOGIN - IQFeed account login (not the one for http://iqfeed.net site, by for IQFeed client)
* PASSWORD - IQFeed account password
* APP_NAME - application name that is passed to the IQFeed server (if you don't have one, or don't know it, it will still work with IQFEED_DEMO app name)
* APP_VERSION - application version that is passed to IQFeed (defaults to 1.0.0.0)

Building docker image
---------------------

If you want to build your own image, probably with modification, follow the steps below.

I recommend doing it on Ubuntu 14.04 machine so that it is similar to what is within container and Wine application installed on host machine will work well within container. You can set up one in 5 minutes using, for example, http://digitalocean.com.

Idea and Makefile are borrowed from https://github.com/macdice/iqfeed-debian.

1. Install wine

```
apt-get install -y software-properties-common
add-apt-repository -y ppa:ubuntu-wine/ppa
apt-get update
apt-get -y install wine1.7
```

2. You need a GUI for this to work, so if you're doing it on server, [install vncserver](http://www.howtoforge.com/how-to-install-vnc-server-on-ubuntu-14.04).

3. Run `make fetch` in this folder to download IQFeed Client installation file. You can change IQFeed Client version at the top of Makefile.

4. Launch GUI.

5. Run `make install`. Don't change default settings.

6. Run `make launch`. Enter your username and password, check "Save Login And Password" and "Automatically Connect" checkboxes.

7. You can exit GUI now.

8. Edit iqfeed.conf and enter your desired iqfeed version and product name.

9. Install docker, if you haven't before: `curl -sSL https://get.docker.io/ubuntu/ | sudo sh`.

10. In the current folder, run `docker build -t iqfeed .`.

11. Your image is ready and named `iqfeed`.

You can run it now: `docker run -e LOGIN=login -e PASSWORD=password iqfeed`.

For transferring image between machines, you can use http://hub.docker.com. For example, if your account on Docker Hub is "bratchenko", you should run `docker build -t bratchenko/iqfeed .`, then `docker push bratchenko/iqfeed`. Then on the target machine, run `docker pull bratchenko/iqfeed` and `docker run --net="host" bratchenko/iqfeed`.