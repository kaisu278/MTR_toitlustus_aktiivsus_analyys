#!/bin/bash

set -e

echo "Käivitan Docker teenused..."
docker compose up -d --build

echo "Käivitan Python skriptid..."
python3 scripts/01_MTR_alusandmed.py
python3 scripts/02_MTR_to_csv.py
python3 scripts/03_MTA_jooksvad_alusandmed.py
python3 scripts/04_MTA_varasemad_alusandmed.py
python3 scripts/05_MTR_andmed_jagamiseks.py

echo "Käivitan SQL skriptid..."
docker compose exec -T db psql -U praktikum -d praktikum -f /scripts/06_uute_tabelite_laadimine.sql
docker compose exec -T db psql -U praktikum -d praktikum -f /scripts/07_MTR_MTA_andmed_juurde.sql
docker compose exec -T db psql -U praktikum -d praktikum -f /scripts/08_andmete_jagamine_maksu_algus.sql
docker compose exec -T db psql -U praktikum -d praktikum -f /scripts/09_kvaliteedikontroll.sql
docker compose exec -T db psql -U praktikum -d praktikum -f /scripts/10_kokkuvqte.sql

echo ""
echo "Valmis!"
echo "Dashboard: http://localhost:8501"