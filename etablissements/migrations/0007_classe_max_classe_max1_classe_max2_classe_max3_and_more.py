# Generated by Django 4.0 on 2022-03-03 17:02

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('etablissements', '0006_classe_eff_classe_moygen_classe_moygen1_and_more'),
    ]

    operations = [
        migrations.AddField(
            model_name='classe',
            name='max',
            field=models.FloatField(blank=True, null=True),
        ),
        migrations.AddField(
            model_name='classe',
            name='max1',
            field=models.FloatField(blank=True, null=True),
        ),
        migrations.AddField(
            model_name='classe',
            name='max2',
            field=models.FloatField(blank=True, null=True),
        ),
        migrations.AddField(
            model_name='classe',
            name='max3',
            field=models.FloatField(blank=True, null=True),
        ),
        migrations.AddField(
            model_name='classe',
            name='min',
            field=models.FloatField(blank=True, null=True),
        ),
        migrations.AddField(
            model_name='classe',
            name='min1',
            field=models.FloatField(blank=True, null=True),
        ),
        migrations.AddField(
            model_name='classe',
            name='min2',
            field=models.FloatField(blank=True, null=True),
        ),
        migrations.AddField(
            model_name='classe',
            name='min3',
            field=models.FloatField(blank=True, null=True),
        ),
    ]
