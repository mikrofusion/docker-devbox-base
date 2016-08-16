Install docker.

Put this in ``` ~/.ssh/config ```:

```
Host devbox
  HostName localhost
  Port 33322
  User mikrofusion
  ForwardAgent true

  # prevent remote host identification warnings
  StrictHostKeyChecking no
  UserKnownHostsFile=/dev/null
```

then run:

```
ssh localbox -t tmux attach -t 0
```

