from django.shortcuts import render,redirect
from django.views.generic import DetailView, ListView,TemplateView, CreateView, UpdateView, DeleteView
from django.contrib.auth.models import User
from django.contrib.auth.decorators import user_passes_test

from etablissements.models import *
from django.http import HttpResponse
from bulletin.models import *
from bulletin.forms import *
from django.urls import reverse

 # les opérations sur Elève dans un établissement
class ELeveIndexView(ListView):
        model = Eleve
        template_name = 'eleve/index.html'
        context_object_name = 'eleves'

class ELeveDetailView(DetailView):
        model = Eleve
        template_name = 'eleve/detail.html'
        context_object_name = 'eleve'

class ELeveCreateView(CreateView):
        model = Eleve
        template_name = 'eleve/nouveau.html'
        form_class =EleveForm
        context_object_name = 'eleve'

        def get_success_url(self):
            return reverse('eleve_show', args=[self.object.pk])

        def get_context_data(self, **kwargs):
            context = super().get_context_data(**kwargs)
            context['submit_text'] = 'Ajouter'
            return context
class ELeveUpdateView(UpdateView):
        model = Eleve
        template_name = 'eleve/nouveau.html'
        form_class = EleveForm
        context_object_name = 'eleve'
        def get_success_url(self):
            return reverse('eleve_show', args=[self.object.pk])
        def get_context_data(self, **kwargs):
            context = super().get_context_data(**kwargs)
            context['submit_text'] = 'Modifier'
            return context
#Autres methode sur élève
def liste_eleves_classe(request, pk):
    # get module
    classe = Classe.objects.get(pk=pk)

    # get all notes module
    eleves =Eleve.objects.filter(classe=classe)
    eff(classe)
    context = {
        'classe': classe,
        'eleves': eleves,
    }

    return render(request, 'eleve/index.html', context)
def liste_matieres_classe(request, pk):
        # get module
        classe = Classe.objects.get(pk=pk)

        # get all notes module
        matieres = MatiereClasse.objects.filter(classe=classe)
        eff(classe)
        context = {
            'classe': classe,
            'matieres': matieres,
        }

        return render(request, 'matieres/index.html', context)

#Autres methode sur élève
def liste_eleves_matiere(request, pk):
        # get module
        matiere = MatiereClasse.objects.get(pk=pk)
        eff(matiere.classe)
        # get all notes module
        eleves = Eleve.objects.filter(classe= matiere.classe).order_by('-moy1')
        context = {
            'matiere': matiere,
            'eleves': eleves,
        }

        return render(request, 'important/index.html', context)


def liste_notes_matiere(request, pk):
    # get module
    matiere = MatiereClasse.objects.get(pk=pk)

    # get all notes module
    notes = MoyenneMatiere.objects.filter(matiere=matiere)


    context = {
        'matiere': matiere,
        'notes': notes,

    }

    return render(request, 'moyenne/index.html', context)

def liste_notes_eleve(request, pk):
    # get module
    eleve= Eleve.objects.get(pk=pk)

    # get all notes module
    notes = MoyenneMatiere.objects.filter(eleve=eleve).order_by('matiere')
    calcule_rang(eleve)
    calcule_rangel(eleve)
    calcule_total(eleve)
    calcule_coef(eleve)
    calcule_moy1(eleve)
    context = {
        'eleve': eleve,
        'notes': notes,

    }

    return render(request, 'moyenne/eleve.html', context)

def calcule_total(eleve):
    eleve.tot1 = 0
    notes = MoyenneMatiere.objects.filter(eleve=eleve)
    for note in notes:
        eleve.tot1 = eleve.tot1+note.moycoef
        eleve.save()

    return eleve
def calcule_rangel(eleve):

    eleve.rang1 = rang_el(eleve)
    eleve.save()

    return eleve

def calcule_rang(eleve):

    notes = MoyenneMatiere.objects.filter(eleve=eleve)
    for note in notes:
        note.rang = rang_mat(note)
        note.save()

    return eleve
def calcule_coef(eleve):
    eleve.totcoef = 0
    matieres = MatiereClasse.objects.filter(classe=eleve.classe)
    for matiere in matieres:
        eleve.totcoef = eleve.totcoef + matiere.coef
        eleve.save()

    return eleve
def calcule_moy1(eleve):
    eleve.moy1 = round(eleve.tot1/eleve.totcoef, 2)
    eleve.save()
    return eleve
def rang_el(el):
    eleves = Eleve.objects.filter(classe=el.classe).order_by('-moy1')
    rang=1
    for eleve in eleves:
        if eleve==el:
            rang = rang
            return rang
        else:
            rang=rang+1

    eleve.rang1=rang
    eleve.save()
    return eleve
def rang_mat(noteel):
    notes = MoyenneMatiere.objects.filter(matiere=noteel.matiere)
    rang=1
    for note in notes:
        if note==noteel:
            rang = rang
            return rang
        else:
            rang=rang+1

    note.rang=rang
    note.save()
    return note
@user_passes_test(lambda u: u.is_superuser or 'Chef' in [group.name for group in u.group.all()] or  matiere.enseignant ==u  )
def register_note(request, pk,id):
    # get module
    matiere = MatiereClasse.objects.get(pk=pk)

    # get all notes module
    eleve = Eleve.objects.get(pk=id)

    if request.method == "POST":
        form = MoyenneForm(request.POST)
        if form.is_valid():
            moyenne = form.save(commit=False)
            moyenne.matiere = matiere
            moyenne.eleve = eleve
            moyenne.calcule_moy()


            moyenne.save()
            return  redirect('notes_matiere', pk=matiere.id)
    else:
        form = MoyenneForm()

    context = {
        'matiere': matiere,
        'eleve': eleve,
        'form': form,
    }
    return render(request, "moyenne/nouveau.html", context)

class MoyenneUpdateView(UpdateView):
        model = MoyenneMatiere
        template_name = 'moyenne/nouveau.html'
        form_class = Moyenne1Form
        context_object_name = 'moyenne'

        def get_success_url(self):
            return reverse('notes_matiere', args=[self.object.matiere.pk])

        def form_valid(self, form):
            form.instance.calcule_moy()
            return super().form_valid(form)

        def get_context_data(self, **kwargs):
            context = super().get_context_data(**kwargs)
            context['submit_text'] = 'Modifier'
            return context
def notespdf(request, pk):
    matiere = MatiereClasse.objects.get(pk=pk)

    # get all notes module
    notes = MoyenneMatiere.objects.filter(matiere=matiere)

    context = {
        'matiere': matiere,
        'notes': notes,
    }
    return render(request, 'moyenne/notepdf.html', context)

class MoyenneDeleteView(DeleteView):
        model = MoyenneMatiere
        template_name = 'moyenne/del.html'
        context_object_name = 'moyenne'

        def get_success_url(self):
            return reverse('notes_matiere', args=[self.object.matiere.pk])
def bul(request, pk):
    classe = Classe.objects.get(pk=pk)
    eleves = Eleve.objects.filter(classe = classe)
    for eleve in eleves:
        notes_eleve(eleve)
        notes = MoyenneMatiere.objects.filter(eleve=eleve).order_by('matiere')
        context = {
            'eleve': eleve,
            'notes': notes,
        }
        return context


    return render(request, 'moyenne/bul.html', context, eleves)




def notes_eleve(eleve):
        calcule_rang(eleve)
        calcule_total(eleve)
        calcule_coef(eleve)
        calcule_moy1(eleve)
        calcule_rangel(eleve)
        return eleve

def eff(classe):
    eleves = Eleve.objects.filter(classe=classe)
    classe.eff = eleves.count()
    classe.save()
    return classe



def calcule_moygen1(classe):
    tot = 0
    eleves = Eleve.objects.filter(classe=classe)
    for eleve in eleves:
       tot = tot+eleve.moy1
       return tot
    classe.moygen1 =round(tot/classe.eff,2)
    classe.save()
    return classe
def calcule_classe(classe):
    classe.moygen1 = calcule_moygen1(classe)
    classe.save()
    return classe

def bulletins(request, pk):
        # get module
        classe = Classe.objects.get(pk=pk)
        # get all notes module
        examen = Examen.objects.get(classe=classe)
        eleves = Eleve.objects.filter(classe=classe).order_by('-moy1')
        notes = MoyenneMatiere.objects.all().order_by('matiere')
        facultatives =Facultative.objects.filter(classe =classe)
        calcule_classe(classe)
        context = {
            'classe': classe,
            'eleves': eleves,
            'notes' : notes,
           'examen' : examen,
            'facultatives' : facultatives
        }

        return render(request, 'important/buls.html', context)
