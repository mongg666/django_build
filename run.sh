#!/bin/sh

# Ожидание готовности PostgreSQL
until pg_isready -h app-postgres -U django_app -d django_app; do
  echo "PostgreSQL недоступен, ждем..."
  sleep 5
done

# Применение миграций
python manage.py migrate --noinput

# Создание суперпользователя (если не существует)
if [ "$CREATE_SUPERUSER" = "true" ]; then
  if [ -z "$(python manage.py shell -c 'from django.contrib.auth.models import User; print(User.objects.filter(username="admin").exists())' | grep 'True')" ]; then
    python manage.py createsuperuser --noinput \
      --username admin \
      --email admin@example.com
  fi
  # Отключаем переменную после создания
  export CREATE_SUPERUSER="false"
fi

# Сборка статических файлов
python manage.py collectstatic --noinput

# Запуск сервера
python manage.py runserver 0.0.0.0:8000