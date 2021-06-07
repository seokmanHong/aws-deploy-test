# Advertiser api
*Studiomate advertiser service*

-----------------------------------

##### Initial setup

- Download git Repository.
```bash
git clone http://advertiser-app.git .
```

- Run followings where `docker-compose.yml` located in
```bash
docker-compose --env-file .build/.env.local \
  up -d \ 
  advertiser-api mysql redis
```


Local service url might be : [http://localhost:8001](http://localhost:8001)

You can change your proxy service port in `docker-compose.yml` as well

## Package version
Laravel : 8.X

PHP: 8.0.6

Nginx: 1.24.0

-----------------------

> Do not modify anything under `.build`
>
> if you do not fully understand the code in it  
