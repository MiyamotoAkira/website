---
title: My newest websites setup
date: 2019-05-04 05:00
excerpt: Or why did I put myself into doing this.
tags:
- Infrastructure
---

So, a month after I started this blog, maybe I can actually finish it. Let's see...

So I wanted to create two new blogs, one for [political/philosophical writing](https://onpolitics.uk/), the other for [fiction writing](https://awinterstale.uk/). Both things do interest me. So it was time to decide how to handle the blogs.

This blog is a [Jekyll](https://jekyllrb.com/) website, with source control on [Github](https://github.com/), CI on [Travis](https://travis-ci.org/), deployed onto a [Digital Ocean](https://www.digitalocean.com/) droplet, using [Nginx](https://www.nginx.com/) as the webserver and [Let's Encrypt](https://letsencrypt.org/) for the encryption. I could have just done the same, using the existing infrastructure, and get it done easily. But, of course, where is the fun on that?

So I decided to have some changes. For one I have gone with the combo [Hugo](https://gohugo.io/), GitHub, [CircleCI](https://circleci.com/), with a new DigitalOcean droplet, Nginx and Let's Encrypt. For the other is Hugo, [GitLab](https://gitlab.com/), GitlabCI and again DigitalOcean, Nginx and Let's Encrypt.

Because I was already changing a few of the options, I decided to keep the same infra type with Digital Ocean. So far they haven't given me any problems. I expect my blog is not very much read, that's fine, so performance doesn't seem to be an issue (free of Javascript and bloated libraries that have no use on a static website).

I have done nothing with the Hugo websites other than create a blank one. I need to learn how to deal with templates and CSS on it, which hopefully will start this weekend. And put some content, quite important .. probably :-)

Although I'm using different CIs, the issues that I encountered when trying to setup both of them were similar. Both of them allow you to use a docker image, which Travis doesn't and not sure what will happen with them now that they have been bought by [Idera](https://en.wikipedia.org/wiki/Idera,_Inc.)

I like that, because I can have a pre-cooked image with Hugo, git and rsync, all three, which I will need to compile and deploy the app. But as I was starting to create the image, and probably because it was the same image for both of them, I realized that well, it was time to create a separate project for docker images which you can find on my [dockerprojects](https://github.com/MiyamotoAkira/dockerprojects) repo. Both builds now can pull the image from [dockerhub](https://cloud.docker.com/u/jorgegueorguiev/repository/docker/jorgegueorguiev/hugo)

To deploy onto the droplets I use rsync. So here we have an interesting thing going on. CircleCi has a command to allow you add ssh keys (and you will see how well named is):

```
- add_ssh_keys
```

Meanwhile GitlabCI doesn't, and I have to do the same commands that I would need to do on my personal machine:
```
- eval $(ssh-agent -s)
- echo "$DEPLOY_KEY" | ssh-add -
- mkdir -p ~/.ssh
- chmod 700 ~/.ss
```

This is something they could improve.

Then you just need to use rsync with the no StrictHostKeyChecking:

`- run: rsync -av -e "ssh -o StrictHostKeyChecking=no" --quiet --delete-after ./public/* ${DEPLOY_USER}@${DEPLOY_HOST}:${DEPLOY_DIRECTORY}`

Easy. I picked up the basic instructions from another blogger, and you can find a more detailed description here:

[https://blog.khophi.co/deploy-to-digitalocean-from-circleci-overcome-permission-denied/](https://blog.khophi.co/deploy-to-digitalocean-from-circleci-overcome-permission-denied/)

The next interesting part was about the changes needed on the droplet. Basic instructions about using nginx can be found here:

[https://www.digitalocean.com/community/tutorials/how-to-install-nginx-on-ubuntu-18-04](https://www.digitalocean.com/community/tutorials/how-to-install-nginx-on-ubuntu-18-04)

The basics of the configuration is:
```
server {
    listen 80 default_sserver;
    listen [::]:80;

    server_name mydomainname;
}
````

Don't be me and try to be clever and add immediately the 443 port configuration for HTTPS. Why? Because the easiest way to setup the encryption was using [certbot](https://certbot.eff.org/) (thanks [EFF](https://www.eff.org/)) with the instructions here:

[https://certbot.eff.org/lets-encrypt/ubuntubionic-nginx](https://certbot.eff.org/lets-encrypt/ubuntubionic-nginx)

It does it all for you ... as long as that port 443 is not declared, nor basically much else, otherwise it gets confused and cannot find your website.

And that's it. Does it take longer than Medium to setup? After my first experience with Medium, I can say yes, it does, but is so worthy. Of course, if you are not a developer/sysops, then probably is going to be too much for you, but for me, allows me to have far more control and avoid all the stuff that makes web browsing at the moment such a pain.

Now, about that content and CSS that I have to create ...
