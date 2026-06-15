# README

Add the followind to `Containerfile`

```bash
COPY system_files/fonts/ /usr/share/fonts/
RUN fc-cache -f /usr/share/fonts/
```

`fc-cache -f` forces font cache generation. It's not mandatory and it will be executed at first boot anyway.
