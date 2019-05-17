# README
* Ruby version: 2.5.3
* Rails: 5.2.2
* Database: Postgresql
* Services: Redis-server, Sidekiq, Sphinx Search.

 

### Quick start

$ redis-server

$ sidekiq -q default -q mailers

$ rails s

### VK, Facebook, GitHub SingUp API

Must set credentials.

```
development:
  facebook:
    app_id: xxx
    app_secret: xxx
  github:
    app_id: xxx
    app_secret: xxx
  vkontakte:
    client_id: xxx
    app_secret: xxx    

  aws:  
    access_key_id: xxx
    secret_access_key: xxx
    bucket: xxx
```

For production, for example, add:

```
  yandex_mail:
    user_name: xxx
    password: xxx
    
  examtutor_database_password: xxx
```
