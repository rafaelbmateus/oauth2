# OAuth 2.0 and OpenID Connect Provider

This project use ory products to build easily authorization server solution.

## How to run?

To build and start the OAuth2 server exec:

```bash
make start
```

## Public endpoints

### Get a new token

```bash
curl -X POST http://localhost:4444/oauth2/token \
  --form 'client_id="11d6ee14-5c2c-44e5-a655-015707cda81c"' \
  --form 'client_secret="17AsrOANi2w2xoSQBpd91lxq6_"' \
  --form 'grant_type="client_credentials"' \
  --form 'scope="books.read"'
```

## Admin endpoints

### Create an OAuth2 client

To create a new OAuth2 client send an request like it:

**Request:**

```bash
curl -X POST 'http://localhost:4445/clients' \
  --header 'Content-Type: application/json' \
  --data-raw '{
    "client_name": "Client Name",
    "grant_types": [
        "client_credentials"
    ],
    "response_types": [
        "code"
    ],
    "scope": "books.read",
    "token_endpoint_auth_method": "client_secret_post"
  }'
```

**Response:**

```json
{
    "client_id": "c355ce15-7e3d-4124-98f9-263f3ba7f49a",
    "client_name": "Client Name",
    "client_secret": "gjReK0zMBzXFBNnumPVNWj3FXZ",
    "redirect_uris": [],
    "grant_types": [
        "client_credentials"
    ],
    "response_types": [
        "code"
    ],
    "scope": "openid offline",
    "audience": [],
    "owner": "",
    "policy_uri": "",
    "allowed_cors_origins": [],
    "tos_uri": "",
    "client_uri": "",
    "logo_uri": "",
    "contacts": null,
    "client_secret_expires_at": 0,
    "subject_type": "public",
    "jwks": {},
    "token_endpoint_auth_method": "client_secret_post",
    "userinfo_signed_response_alg": "none",
    "created_at": "2021-06-24T13:25:12Z",
    "updated_at": "2021-06-24T13:25:12.300385Z",
    "metadata": {}
}
```

### List OAuth2 clients

```bash
curl http://localhost:4445/clients
```

### Get an OAuth2 client by client_id

```bash
curl http://localhost:4445/clients/c355ce15-7e3d-4124-98f9-263f3ba7f49a
```

### Delete an OAuth2 client

```bash
curl -X DELETE http://localhost:4445/clients/c355ce15-7e3d-4124-98f9-263f3ba7f49a
```

### Check alive status

```bash
curl http://localhost:4445/health/alive
```

**Response:**

```json
{"status":"ok"}
```

### Introspect OAuth2 tokens

```bash
curl -X POST http://localhost:4445/oauth2/introspect \
  --header 'Content-Type: application/x-www-form-urlencoded' \
  --data-urlencode 'token=xjqt2ayi1R2LYwEE_T7bXFJkja2tONj5hfpYh_dsaP0.ztLgp8TMI6xy5eRl5qgI3iWRqhSd9qAWBCbcDJZT2GQ'
```

If you want to validate the scope, send this parameter:

```bash
curl -X POST http://localhost:4445/oauth2/introspect \
  --header 'Content-Type: application/x-www-form-urlencoded' \
  --data-urlencode 'scope=books.read' \
  --data-urlencode 'token=xjqt2ayi1R2LYwEE_T7bXFJkja2tONj5hfpYh_dsaP0.ztLgp8TMI6xy5eRl5qgI3iWRqhSd9qAWBCbcDJZT2GQ'
```

**Response:**

```json
{
    "active": true,
    "scope": "books.read",
    "client_id": "c355ce15-7e3d-4124-98f9-263f3ba7f49a",
    "sub": "c355ce15-7e3d-4124-98f9-263f3ba7f49a",
    "exp": 1624545974,
    "iat": 1624542374,
    "nbf": 1624542374,
    "aud": [],
    "iss": "http://127.0.0.1:4444/",
    "token_type": "Bearer",
    "token_use": "access_token"
}
```

## References

https://www.ory.sh/hydra
