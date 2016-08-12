Put this in ``` ~/.ssh/config ```:

```
Host localbox
  HostName localhost
  Port 33333
  User mikrofusion
  ForwardAgent true
```

then run:

```
ssh localbox
```

