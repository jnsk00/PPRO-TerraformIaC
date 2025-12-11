# PPRO-Terraform: Infrastructure as Code (IaC) – Praktická Demonstrace

## 🎯 Cíl semestrálního projektu

Tento projekt slouží jako **praktická část** prezentace na téma **Infrastructure as Code (IaC)** s využitím nástroje **Terraform**. Cílem je demonstrovat kompletní automatizovaný proces nasazení moderní mikroslužby a navázat tak na znalosti z předmětů jako Docker, Kubernetes či CI/CD.

### Anotace projektu

> „Praktická část naváže na znalosti studentů z předchozích cvičení, jako jsou Docker, Kubernetes, mikroslužby a CI/CD, a ukáže, jak lze automatizovaně nasadit Spring Boot aplikaci v Kotlinu do lokálního prostředí spravovaného Terraformem. Přínosem prezentace a workshopu bude demonstrace propojení vývojového procesu s automatizovaným nasazením infrastruktury.“

---

## 🛠️ Použité technologie a architektura

| Oblast             | Technologie          | Účel v projektu                                                            |
| :----------------- | :------------------- | :------------------------------------------------------------------------- |
| **Aplikace**       | Spring Boot (Kotlin) | Jednoduchá REST API mikroslužba („Hello World“).                           |
| **Kontejnerizace** | Docker               | Kontejnerizace aplikace pro zajištění přenositelnosti.                     |
| **Orchestrace**    | Kubernetes           | Nasazení a běh kontejnerů (Deployment, Service).                           |
| **IaC**            | Terraform            | Deklarativní definice a správa infrastruktury (image build + K8s objekty). |
| **Automatizace**   | GitHub Actions       | CI/CD pipeline pro validaci a plánování změn.                              |

---

## 📂 Struktura repozitáře

```
PPRO-Terraform/
├── .github/workflows/
│   └── terraform-ci.yml        # CI/CD pipeline
│
├── spring-app/
│   ├── build.gradle.kts        # Build konfigurace aplikace
│   ├── Dockerfile              # Definice Docker image
│   └── src/                    # Zdrojový kód aplikace
│
└── terraform/
    ├── providers.tf            # Konfigurace Terraform providerů (Docker, Kubernetes)
    ├── variables.tf            # Vstupní proměnné (port, počet replik)
    ├── main.tf                 # Hlavní logika nasazení
    ├── outputs.tf              # Výstupní hodnoty (např. NodePort)
    └── README.md
```

---

## ⚙️ Lokální demostrace (Workshop)

Tato část slouží k praktické ukázce nasazení aplikace pomocí Terraformu.

### Předpoklady

* nainstalovaný a spuštěný **Docker** (Pokud nemáte, tak hlavní stránky Dockeru https://www.docker.com/)
* lokální **Kubernetes cluster** (Minikube nebo Docker Desktop)
* nainstalované **Terraform CLI** (https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

---

### 1. Inicializace Terraformu

V adresáři `terraform` spusťte inicializaci, která stáhne a připraví potřebné providery:

```bash
terraform init
```

---

### 2. Plánování změn („dry run“)

Terraform zobrazí, jaké změny chce provést, aniž by je skutečně aplikoval:

```bash
terraform plan
```

---

### 3. Aplikace konfigurace (nasazení)

Terraform provede kompletní automatizované nasazení:

1. sestaví Docker image z `spring-app/Dockerfile`
2. vytvoří Kubernetes Deployment (výchozí 2 repliky)
3. vytvoří Kubernetes Service typu NodePort

Spusťte:

```bash
terraform apply
```

Po výzvě potvrďte `yes`.

---

### 4. Ověření a přístup k aplikaci

Terraform vypíše port aplikace definovaný v `outputs.tf`.

Pokud používáte Minikube:

```bash
minikube service spring-app-demo
```

Obecně je aplikace dostupná na:

```
http://<localhost>:<NodePort>
```

---

### 5. Úklid prostředí

Pro demonstraci idempotentnosti a snadného odstranění infrastruktury:

```bash
terraform destroy
```

---

## 🌐 CI/CD integrace (GitHub Actions)

Soubor `.github/workflows/terraform-ci.yml` definuje jednoduchou CI/CD pipeline, která se spouští při každé změně v repozitáři.

Pipeline demonstruje základní CI/CD principy:

* **Validace** – kontrola syntaxe a konzistence Terraform kódu
  `terraform validate`
* **Plánování změn** – automatický náhled plánovaných úprav
  `terraform plan`
  (výstup lze použít pro code review a schválení)

---
