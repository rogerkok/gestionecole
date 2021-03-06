# Generated by Django 4.0 on 2022-03-04 13:41

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('etablissements', '0008_etablissement_plan_alter_enseignant_photo'),
    ]

    operations = [
        migrations.AlterField(
            model_name='dre',
            name='drapeau',
            field=models.ImageField(blank=True, null=True, upload_to='pays'),
        ),
        migrations.AlterField(
            model_name='etablissement',
            name='logo',
            field=models.ImageField(blank=True, null=True, upload_to='ets'),
        ),
        migrations.AlterField(
            model_name='etablissement',
            name='plan',
            field=models.ImageField(blank=True, null=True, upload_to='ets/plan'),
        ),
    ]
