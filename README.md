Install docker (https://www.docker.com/products/docker).
Install XQuarts (https://www.xquartz.org/) for copy/paste between systems.
Note: ensure syncing is enabled under XQuartz -> Preferences -> Pasteboard

clone repo, cd into repo, and run ` make `

Put this in ``` ~/.ssh/config ```:

```
Host devbox
  HostName localhost
  Port 33322
  User mikrofusion
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

