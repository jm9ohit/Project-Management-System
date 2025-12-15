# Project Management System

A full-stack project management app built with **Django**, **GraphQL**, **React**, and **TypeScript**.

## Features
- Multi-tenant (organization-based)  
- GraphQL API + PostgreSQL  
- React + Apollo + TailwindCSS UI  
- Task & Project management board  

## Setup
```bash
# Backend
cd backend
pip install -r requirements.txt
python manage.py migrate
python manage.py runserver

# Frontend
cd frontend
npm install
npm start
