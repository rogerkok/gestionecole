from django.shortcuts import render,redirect
from django.views.decorators.csrf import csrf_exempt
from rest_framework.parsers import JSONParser
from etablissements.models import *
from etablissements.serializers import AnneeScolaireSerializer, MatiereSerializer,EnseignantSerializer
from django.http.response import JsonResponse
from django.http import HttpResponse
from django.core.files.storage import default_storage
from django.views.generic import DetailView, ListView,TemplateView, CreateView, UpdateView
from etablissements.forms import *
from django.urls import reverse


# Create your views here.
@csrf_exempt
def anneeApi(request,id=0):
    if request.method=='GET':
        annees = AnneeScolaire.objects.all()
        annees_serializer = AnneeScolaireSerializer(annees, many=True)
        return JsonResponse(annees_serializer.data, safe=False)
    elif request.method=='POST':
        annee_data=JSONParser().parse(request)
        annee_serializer = AnneeScolaireSerializer(data=annee_data)
        if annee_serializer.is_valid():
            annee_serializer.save()
            return JsonResponse("Année ajoutée avec succès", safe=False)
        return JsonResponse("Echec", safe=False)
    elif request.method=='PUT':
        annee_data=JSONParser().parse(request)
        annee = AnneeScolaire.objects.get(id=annee_data['id'])
        annee_serializer = AnneeScolaireSerializer(annee, data=annee_data)
        if annee_serializer.is_valid():
            annee_serializer.save()
            return JsonResponse("Mise à jour avec succès", safe=False)
        return JsonResponse("Echec", safe=False)
    elif request.method=='DELETE':
        annee = AnneeScolaire.objects.get(id=id)
        annee.delete()
        return JsonResponse("Suppression avec succès", safe=False)
@csrf_exempt
def matiereApi(request,id=0):
    if request.method=='GET':
        matieres = Matiere.objects.all()
        matieres_serializer = MatiereSerializer( matieres, many=True)
        return JsonResponse( matieres_serializer.data, safe=False)
    elif request.method=='POST':
        matiere_data=JSONParser().parse(request)
        matiere_serializer = MatiereSerializer(data= matiere_data)
        if  matiere_serializer.is_valid():
            matiere_serializer.save()
            return JsonResponse("Matière ajoutée avec succès", safe=False)
        return JsonResponse("Echec", safe=False)
    elif request.method=='PUT':
        matiere_data=JSONParser().parse(request)
        matiere = Matiere.objects.get(id= matiere_data['id'])
        matiere_serializer = MatiereSerializer( matiere, data= matiere_data)
        if  matiere_serializer.is_valid():
            matiere_serializer.save()
            return JsonResponse("Mise à jour avec succès", safe=False)
        return JsonResponse("Echec", safe=False)
    elif request.method=='DELETE':
        matiere =Matiere.objects.get(id=id)
        matiere.delete()
        return JsonResponse("Suppression avec succès", safe=False)
@csrf_exempt
def ensApi(request,id=0):
    if request.method=='GET':
        enseignants = Enseignant.objects.all()
        enseignants_serializer =EnseignantSerializer(enseignants, many=True)
        return JsonResponse( enseignants_serializer.data, safe=False)
    elif request.method=='POST':
        enseignant_data=JSONParser().parse(request)
        enseignant_serializer = EnseignantSerializer(data= enseignant_data)
        if enseignant_serializer.is_valid():
            enseignant_serializer.save()
            return JsonResponse("Enseignant ajoutée avec succès", safe=False)
        return JsonResponse("Echec", safe=False)
    elif request.method=='PUT':
        enseignant_data=JSONParser().parse(request)
        enseignant = Enseignant.objects.get(id= enseignant_data['id'])
        enseignant_serializer = EnseignantSerializer( enseignant, data= enseignant_data)
        if  enseignant_serializer.is_valid():
            enseignant_serializer.save()
            return JsonResponse("Mise à jour avec succès", safe=False)
        return JsonResponse("Echec", safe=False)
    elif request.method=='DELETE':
        enseignant =Enseignant.objects.get(id=id)
        enseignant.delete()
        return JsonResponse("Suppression avec succès", safe=False)
@csrf_exempt
def savefile(request):
    file= request.FILES['uploadFile']
    file_name = default_storage.save(file.name,file)
    return JsonResponse(file_name, safe=False)


def newdre(request):
    form = DreForm()
    return render(request,'etablissements/newdre.html', {'form':form} )
def newets(request):
    if request.method == "POST":
        form = EtablissementForm(request.POST)
        if form.is_valid():
            form.save()
            return HttpResponse('Enregistrement avec succès')
    else:
        form = EtablissementForm()
    return render(request,'etablissements/newets.html', {'form':form} )

# les opérations sur classe dans un établissement
class ClasseIndexView(ListView):
    model = Classe
    template_name = 'classe/index.html'
    context_object_name = 'classes'
class ClasseDetailView(DetailView):
    model = Classe
    template_name = 'classe/detail.html'
    context_object_name = 'classe'
class ClasseCreateView(CreateView):
    model = Classe
    template_name = 'classe/nouveau.html'
    form_class = ClasseForm
    context_object_name = 'classe'

    def get_success_url(self):
        return reverse('classe_show', args=[self.object.pk])
# les opérations sur Enseignant dans un établissement
class EnseignantIndexView(ListView):
   model = Enseignant
   template_name = 'enseignant/index.html'
   context_object_name = 'enseignants'
class EnseignantDetailView(DetailView):
    model = Enseignant
    template_name = 'enseignant/detail.html'
    context_object_name = 'enseignant'
class EnseignantCreateView(CreateView):
    model = Enseignant
    template_name = 'enseignant/nouveau.html'
    form_class = EnseignantForm
    context_object_name = 'enseignant'

    def get_success_url(self):
        return reverse('eenseignant_show', args=[self.object.pk])

    # les opérations sur matière de classe dans un établissement
class MatiereIndexView(ListView):
        model = MatiereClasse
        template_name = 'matieres/index.html'
        context_object_name = 'matieres'

class MatiereDetailView(DetailView):
        model = MatiereClasse
        template_name = 'matieres/detail.html'
        context_object_name = 'matiere'

class MatiereCreateView(CreateView):
        model = MatiereClasse
        template_name = 'matieres/nouveau.html'
        form_class = MatiereClasseForm
        context_object_name = 'matiere'

        def get_success_url(self):
            return reverse('matiere_show', args=[self.object.pk])
        def get_context_data(self, **kwargs):
            context = super().get_context_data(**kwargs)
            context['submit_text'] = 'Ajouter'
            return context
class MatiereUpdateView(UpdateView):
        model = MatiereClasse
        template_name = 'matieres/nouveau.html'
        form_class = MatiereClasseForm
        context_object_name = 'matiere'

        def get_success_url(self):
            return reverse('matiere_show', args=[self.object.pk])

        def get_context_data(self, **kwargs):
            context = super().get_context_data(**kwargs)
            context['submit_text'] = 'Modifier'
            return context


def claseets(request, pk):
    # get module
    ets = Etablissement.objects.get(pk=pk)
    classes = Classe.objects.filter(etbs=ets)

    context = {
        'classes': classes,
        'ets':ets,

    }

    return render(request, 'important/buls.html', context)