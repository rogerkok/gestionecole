# Generated by Django 4.0 on 2022-03-04 17:21

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('etablissements', '0010_examen'),
    ]

    operations = [
        migrations.AlterField(
            model_name='examen',
            name='classe',
            field=models.ManyToManyField(null=True, related_name='exams', to='etablissements.Classe'),
        ),
    ]