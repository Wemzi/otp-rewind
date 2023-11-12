Edit the
\otp-rewind-frontend\backend\server\myserver\myserver\settings.py 
file for your personal settings

```python

ALLOWED_HOSTS = ["change this for your IP, or *"]

from django.core.management.commands.runserver import Command as runserver
runserver.default_port = '4242' # <-- Your port
runserver.default_addr = '0.0.0.0' # <-- Your addr example 127.0.1.1. 

```

```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',   # this engine is for mysql, mariadb etc, change it if you don't use this
        'NAME': 'otp_rewind_db',                # Database name
        'USER': 'developer',                    # you are not idiot
        'PASSWORD' : 'develop',                 # I hope know what it looks like
        'HOST': 'localhost',                    # and how to edit this for you
        'PORT': '',                             # if not google it 
    }
}
```
then run `otp-rewind-frontend\backend\server\scripts\migrateDB.sh`


for run the server:
$  cd server/myserver
$  python ./manage.py runserver
