python ../server/myserver/manage.py makemigrations
python ../server/myserver/manage.py migrate
python ../server/myserver/manage.py loaddata ../server/db/otpusers/user.json