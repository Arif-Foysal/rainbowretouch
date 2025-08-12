## Contact (CRUD Operations)

### Create a new contact

```bash
curl -X POST http://localhost:8000/api/contacts \
  -H "Content-Type: application/json" \
  -H "Accept: application/json" \
  -d '{
    "name": "John Doe",
    "email": "john.doe@example.com",
    "phone": "+1-555-0123",
    "service": "Logo Design",
    "message": "I need a professional logo for my startup company."
  }'
```

### Create a contact with minimal data

```bash
curl -X POST http://localhost:8000/api/contacts \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Jane Doe",
    "email": "jane.doe@example.com",
    "message": "Interested in your services."
  }'

### Get all contacts
```bash
curl -X GET http://localhost:8000/api/contacts \
  -H "Accept: application/json"
```

### Get a specific contact by ID

```bash
curl -X GET http://localhost:8000/api/contacts/1 \
  -H "Accept: application/json"
```
### Update a contact by ID

```bash
curl -X PUT http://localhost:8000/api/contacts/1 \
  -H "Content-Type: application/json" \
  -H "Accept: application/json" \
  -d '{
    "status": "read",
    "name": "John Smith Updated"
  }'
```
or,

```bash
curl -X PATCH http://localhost:8000/api/contacts/1 \
  -H "Content-Type: application/json" \
  -H "Accept: application/json" \
  -d '{
    "status": "replied"
  }'
```

### Delete a contact by ID

```bash
curl -X DELETE http://localhost:8000/api/contacts/1 \
  -H "Accept: application/json"
```


## Service api

### Get all services

```bash
curl -X GET http://localhost:8000/api/services \
  -H "Accept: application/json"
```

### Get a specific service by ID

```bash
curl -X GET http://localhost:8000/api/services/1 \
  -H "Accept: application/json"
``` 

### Create a new service (auth required)

```bash
# First, login to get a token
curl -X POST http://localhost:8000/api/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "your@email.com",
    "password": "yourpassword"
  }'

# Then create a service using the token
curl -X POST http://localhost:8000/api/services \
  -H "4|VkwYSzSN6lYPuQimUpSF7Q5RH9aQZOOXY1NAOmVxf78e984e" \
  -H "Content-Type: application/json" \
  -H "Accept: application/json" \
  -d '{
    "name": "Logo Design",
    "description": "Professional logo design services for businesses"
  }'
```

### Update a service by ID (auth required)

```bash
curl -X PUT http://localhost:8000/api/services/1 \
  -H "Content-Type: application/json" \
  -H "Accept: application/json" \
  -d '{
    "name": "Premium Logo Design",
    "description": "High-quality professional logo design services"
  }'
```

### Delete a service by ID (auth required)

```bash
curl -X DELETE http://localhost:8000/api/services/1 \
  -H "Accept: application/json"
```
