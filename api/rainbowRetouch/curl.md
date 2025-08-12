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

