Install docker (https://www.docker.com/products/docker).
Install XQuarts (https://www.xquartz.org/) for copy/paste between systems.
Note: ensure syncing is enabled under XQuartz -> Preferences -> Pasteboard

clone repo, cd into repo, and run ` make `

Put this in ``` ~/.ssh/config ``` (making sure to replace the username which whatever your $USER is):

```
Host devbox
  HostName localhost
  Port 33322
  User <insert your username here>
  ForwardAgent true
  # required for copy / paste between systems
  ForwardX11 yes

  # prevent remote host identification warnings
  StrictHostKeyChecking no
  UserKnownHostsFile=/dev/null
```

then run:

```
ssh devbox
```

Note:

Connecting to devbox requires that you have your public keys in the authorized_keys file here:

```
/home/$USER/.ssh/authorized_keys
```

A useful way to do this is to install github-auth locally and add the keys to your enviornment prior to running ``` make ```

```
# ssh
# https://github.com/chrishunt/github-auth
gem install github-auth --no-rdoc --no-ri
gh-auth add --users=$USER
```

# Repos

The following devbox repos have been built to extend this:

* [docker-elixir-postgres](https://github.com/mikrofusion/docker-devbox-elixir-postgres)
