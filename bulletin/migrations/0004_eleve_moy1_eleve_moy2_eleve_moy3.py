# Generated by Django 4.0 on 2022-02-08 07:41

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('bulletin', '0003_remove_moyennematiere_moy'),
    ]

    operations = [
        migrations.AddField(
            model_name='eleve',
            name='moy1',
            field=models.FloatField(blank=True, null=True),
        ),
        migrations.AddField(
            model_name='eleve',
            name='moy2',
            field=models.FloatField(blank=True, null=True),
        ),
        migrations.AddField(
            model_name='eleve',
            name='moy3',
            field=models.FloatField(blank=True, null=True),
        ),
    ]
