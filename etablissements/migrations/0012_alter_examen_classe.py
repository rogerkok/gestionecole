# Generated by Django 4.0 on 2022-03-04 17:23

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('etablissements', '0011_alter_examen_classe'),
    ]

    operations = [
        migrations.AlterField(
            model_name='examen',
            name='classe',
            field=models.ManyToManyField(null=True, to='etablissements.Classe'),
        ),
    ]
