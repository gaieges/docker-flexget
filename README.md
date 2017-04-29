# Flexget API docker image

> This is intended to spin up a flexget process with an exposed API port purely for that purpose

# Intro

This image is configured to utilize environment vars for most of the configuration.

At the moment, the only available option is to set the api password `FLEXGET_PASSWORD` however it utilizes confd so future env args will be added.

# Getting started

To start up a new api, run:

```bash
docker run -it -p 5050:5050 -e FLEXGET_PASSWORD="my super password" -d gaieges/flexget 
```

And then simply connect to it as follows

```bash
curl http://localhost:5050/api/auth/login/ -H content-type:application/json -i -d '{"username":"flexget", "password": "my super password"}'
```

You can also use the username and password directly in calls to other endpoints:

```bash
curl http://localhost:5050/api/tasks/ --user "flexget:my super password"
```


# Getting token from user 

Using the above request to the `/auth/login/` endpoint, you'll get a token in a cookie that looks like this:

```
Set-Cookie: session=BIG_STRING_HERE; HttpOnly; Path=/
```

This is your session token.  To use the standard token calls that the api uses, get the token by doing the following:

```bash
curl localhost:5050/api/user/token/ -H "Cookie:session=BIG_STRING_HERE"
```

And then use the `token` response value as requests going forward:

```bash
curl localhost:5050/api/tasks/ -H "Authorization: Token TOKEN_FROM_RESPONSE"
```
