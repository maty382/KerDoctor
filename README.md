# KërDoctor 

> **Télémédecine intelligente par la voix pour les travailleurs du secteur informel au Sénégal**

[![FastAPI](https://img.shields.io/badge/FastAPI-0.111.0-009688?style=flat&logo=fastapi)](https://fastapi.tiangolo.com)
[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=flat&logo=flutter)](https://flutter.dev)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15-336791?style=flat&logo=postgresql)](https://postgresql.org)
[![Python](https://img.shields.io/badge/Python-3.12-3776AB?style=flat&logo=python)](https://python.org)

---

##  C'est quoi KërDoctor ?

**Kër** signifie *maison* en Wolof. KërDoctor c'est la santé à domicile.

En moins de 2 minutes, n'importe quel utilisateur peut :
1. Décrire ses symptômes **en Wolof, Français ou Pulaar**
2. Recevoir une **analyse IA immédiate** avec niveau d'urgence
3. Être mis en contact avec un **médecin qualifié**
4. Payer via **Wave ou Orange Money**

**Mission** : Rendre les soins de santé aussi accessibles que passer un coup de téléphone.

---

##  Le problème qu'on résout

- **80%** des travailleurs urbains au Sénégal sont dans le secteur informel
- Files d'attente de **3 à 8 heures** dans les hôpitaux publics
- **0.1 médecin** pour 1 000 habitants (OMS 2023)
- Barrière linguistique — le personnel soignant parle uniquement français
- Pas de protection sociale → perte de revenus journaliers

---

## Architecture

```
KërDoctor/
├── backend/          ← API FastAPI (Saïd Deme)
│   ├── app/
│   │   ├── core/     ← Config, sécurité, dépendances
│   │   ├── db/       ← Connexion PostgreSQL
│   │   ├── models/   ← Tables de la base de données
│   │   ├── schemas/  ← Validation des données (Pydantic)
│   │   ├── services/ ← Logique métier (Auth, Triage IA)
│   │   └── routers/  ← Endpoints API REST
│   └── migrations/   ← Migrations Alembic
└── frontend/         ← App Flutter (Ndeye Maty Ba)
    └── lib/
        ├── screens/  ← Écrans de l'app
        ├── services/ ← Appels API
        └── models/   ← Modèles de données
```

---

## Stack Technologique

| Couche | Technologie | Pourquoi |
|--------|-------------|----------|
| Backend API | Python + FastAPI | Async natif, validation auto, docs Swagger |
| Base de données | PostgreSQL 15 | ACID, JSON natif |
| Cache | Redis | Sessions, rate limiting |
| Speech-to-Text | Faster-Whisper | Multilingue FR/Wolof, open-source, gratuit |
| Triage IA | Groq API (Llama 3) | Inférence rapide, gratuit |
| Frontend Mobile | Flutter (Dart) | iOS + Android, un seul codebase |
| Paiement | Wave API + Orange Money | Leaders Mobile Money Sénégal |
| Téléphonie | Africa's Talking | IVR + SMS + WhatsApp |
| Déploiement | Railway | Auto-scaling, déploiement GitHub |

---

##  Installation — Backend

### Prérequis
- Python 3.12+
- PostgreSQL 15+
- Redis
- Docker (optionnel)

### 1. Clone le repo
```bash
git clone https://github.com/maty382/KerDoctor.git
cd KerDoctor/backend
```

### 2. Crée l'environnement virtuel
```bash
python3 -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate
pip install -r requirements.txt
```

### 3. Configure les variables d'environnement
```bash
cp .env.example .env
```

Remplis le `.env` :
```env
DATABASE_URL=postgresql+asyncpg://postgres:secret@localhost:5432/kerdoctor
REDIS_URL=redis://localhost:6379/0
JWT_SECRET_KEY=change-this-to-a-random-secret
JWT_ALGORITHM=HS256
ACCESS_TOKEN_EXPIRE_MINUTES=60
REFRESH_TOKEN_EXPIRE_DAYS=7
GROQ_API_KEY=ton-api-key-groq
APP_ENV=development
APP_URL=http://localhost:8000
```

### 4. Lance PostgreSQL avec Docker
```bash
docker run -d \
  --name kerdoctor-db \
  -e POSTGRES_PASSWORD=secret \
  -e POSTGRES_DB=kerdoctor \
  -p 5432:5432 \
  postgres:15
```

### 5. Applique les migrations
```bash
alembic upgrade head
```

### 6. Lance le serveur
```bash
uvicorn app.main:app --reload --port 8000
```

### 7. Teste l'API
Ouvre `http://localhost:8000/docs` pour accéder à la documentation Swagger interactive.

---

## 📱 Installation — Frontend Flutter

### Prérequis
- Flutter SDK 3.x+
- Android Studio ou VS Code
- Un émulateur ou appareil physique

```bash
cd KerDoctor/frontend
flutter pub get
flutter run
```

Configure l'URL de l'API dans `lib/config/api_config.dart` :
```dart
const String apiBaseUrl = 'https://backend-production-01b37.up.railway.app/api/v1';
```

---

## 📡 API — Endpoints Principaux

### Authentification
| Méthode | Endpoint | Description | Auth |
|---------|----------|-------------|------|
| POST | `/api/v1/auth/register` | Inscription patient ou médecin | ❌ |
| POST | `/api/v1/auth/login` | Connexion → JWT tokens | ❌ |
| POST | `/api/v1/auth/refresh` | Renouvelle les tokens | ❌ |
| POST | `/api/v1/auth/logout` | Déconnexion | ✅ |
| GET | `/api/v1/auth/me` | Profil utilisateur connecté | ✅ |

### Triage Vocal IA
| Méthode | Endpoint | Description | Auth |
|---------|----------|-------------|------|
| POST | `/api/v1/triage/voice` | Upload audio → analyse IA | ✅ Patient |
| GET | `/api/v1/triage/history` | Historique des triages | ✅ |

### Exemple — Inscription
```bash
curl -X POST "https://api.kerdoctor.com/api/v1/auth/register" \
  -H "Content-Type: application/json" \
  -d '{
    "phone": "+221771234567",
    "full_name": "Fatou Diallo",
    "password": "motdepasse123",
    "role": "patient",
    "language": "wo"
  }'
```

Réponse :
```json
{
  "access_token": "eyJ...",
  "refresh_token": "eyJ...",
  "token_type": "bearer",
  "user_id": "uuid",
  "role": "patient",
  "full_name": "Fatou Diallo"
}
```

### Exemple — Triage Vocal
```bash
curl -X POST "https://api.kerdoctor.com/api/v1/triage/voice" \
  -H "Authorization: Bearer <access_token>" \
  -F "audio_file=@symptomes.wav" \
  -F "language=fr"
```

Réponse :
```json
{
  "id": "uuid",
  "urgency_level": 2,
  "summary": "Le patient décrit des maux de tête et de la fièvre depuis ce matin.",
  "advice": "Prenez du paracétamol. Consultez un médecin si la fièvre dépasse 39°C.",
  "transcript": "J'ai mal à la tête depuis ce matin et j'ai de la fièvre",
  "language": "fr",
  "created_at": "2026-04-11T10:00:00"
}
```

---

## 🗄️ Modèle de Données

```
users           — Tous les utilisateurs (patients, médecins, admins)
doctors         — Profils médecins (spécialité, CNOM, langues)
refresh_tokens  — Tokens JWT de rafraîchissement
triages         — Résultats d'analyses vocales IA
consultations   — Sessions de consultation
payments        — Paiements Wave / Orange Money
reviews         — Notes et avis post-consultation
```

---

## 🔒 Sécurité

- Chiffrement **TLS 1.3** pour toutes les communications
- Mots de passe hashés avec **bcrypt**
- Authentification **JWT** (access 1h + refresh 7j) avec rotation automatique
- Rate limiting : **20 triages/jour/utilisateur**
- Conformité **loi sénégalaise 2008-12** sur la protection des données

---

## 👥 Niveaux d'Urgence

| Niveau | Description | Action |
|--------|-------------|--------|
| 🔴 1 — Critique | Danger immédiat | Alerte SAMU/15 automatique |
| 🟡 2 — Consultation | Voir un médecin sous 24-48h | Matching médecin |
| 🟢 3 — Conseils | Conseils suffisants | Pas de consultation nécessaire |

---

## 🗺️ Roadmap

| Phase | Deadline | Statut |
|-------|----------|--------|
| MVP — Auth + Triage vocal + Wave | 15 avril 2026 | 🟡 En cours |
| V1 — Matching médecin + Consultation + Orange Money | 30 avril 2026 | 📅 Planifié |
| Beta — WhatsApp + Ordonnances + Pulaar + Analytics | 15 mai 2026 | 📅 Planifié |

---

## 👨‍💻 Équipe

| Membre | Rôle | Responsabilités |
|--------|------|-----------------|
| **Saïd Deme** | Backend & AI Lead | FastAPI, PostgreSQL, Whisper, Groq, Railway |
| **Ndeye Maty Ba** | Frontend & DB Lead | Flutter, UI/UX, Paiements |
| **Ndeye Diouka Deme** | Business & Medical Lead | Partenariats médecins, Conformité, Hult Prize |

---

## 📄 Licence

Projet confidentiel — Équipe KërDoctor  
Hult Prize 2026 — Phase Nationale Sénégal

---

*KërDoctor — La santé accessible à tous, dans ta langue, depuis chez toi.*
