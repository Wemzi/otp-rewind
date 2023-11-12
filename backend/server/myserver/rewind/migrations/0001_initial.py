# Generated by Django 4.2.7 on 2023-11-11 11:08

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='User',
            fields=[
                ('id', models.BigAutoField(primary_key=True, serialize=False)),
                ('name', models.CharField(max_length=100)),
                ('country', models.CharField(max_length=5, null=True)),
                ('birthdate', models.DateField()),
            ],
        ),
    ]
