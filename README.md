# Создание кластера mongoDB

## Для Первичной инициализации выполните `make all`. Дайте всем контейнерам развернуться (минуты 3)

### Все команды перечислены в Makefile



### Небольшое допущение. Необходимо добавить в /etc/hosts строки:
```bash
127.0.0.1       mongors1n1
127.0.0.1       mongors1n2
127.0.0.1       mongors1n3
```


### Строка подключения `mongodb://localhost:27017?replicaSet=mongors1`

![Init_Connection.png](images%2FInit_Connection.png)


![Connection_status.png](images%2FConnection_status.png)

```python
from pymongo import MongoClient

if __name__ == '__main__':
    client = MongoClient('mongodb://localhost:27017/?replicaSet=mongors1')
    mydb = client['someDb']
    mycol = mydb['someCollection']

    mydict = {'name': 'John', 'address': 'Highway 37'}

    x = mycol.insert_one(mydict)

    print(x.inserted_id)
```