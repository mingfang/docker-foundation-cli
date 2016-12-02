# docker-foundation-cli
Run Fondation CLI Insider Docker

After building image using ```./build``` script, create these aliases...

```
alias foundation='docker run -p 3000:3000 -v `pwd`:/docker -w /docker --rm -it foundation-cli foundation'
alias foundation-build='docker run -p 3000:3000 -v `pwd`:/docker -w /docker --rm -it foundation-cli npm run build'
```

To create a new email project

```
foundation new --framework emails
```

To watch email project

```
foundation watch
```

To build email project

```
foundation-build
```
