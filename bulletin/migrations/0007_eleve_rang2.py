# Generated by Django 4.0 on 2022-02-17 16:38

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('bulletin', '0006_eleve_rang1_eleve_rang3_moyennematiere_rang'),
    ]

    operations = [
        migrations.AddField(
            model_name='eleve',
            name='rang2',
            field=models.IntegerField(blank=True, null=True),
        ),
    ]
