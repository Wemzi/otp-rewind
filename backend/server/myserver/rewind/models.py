from django.db import models

# Create your models here.
class User(models.Model):
    id = models.BigAutoField(primary_key=True)
    name = models.CharField(max_length=100)
    country = models.CharField(max_length=100, null=True)
    birthdate = models.DateField(null=True)
