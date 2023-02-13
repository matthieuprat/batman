# Boring stuff

## Generating the keypair

To generate the `private_key.pem` and `public_key.pem` files:

```bash
openssl genrsa -out private_key.pem 2048
openssl rsa -in private_key.pem -pubout -out public_key.pem
```

To check that all is good:

```bash
read | openssl rsautl -encrypt -pubin -inkey public_key.pem | base64 | base64 --decode | openssl rsautl -decrypt -inkey private_key.pem
```

## cURL samples

### Zones

```bash
curl --request GET \
     --url 'https://api.robinpowered.com/v1.0/locations/767466/spaces?page=1&per_page=10&include=include' \
     --header 'Authorization: Access-Token $ROBIN_ACCESS_TOKEN' \
     --header 'accept: application/json'
```

### Spaces

```bash
curl --request GET \
     --url 'https://api.robinpowered.com/v1.0/spaces/203506/zones?page=1&per_page=10' \
     --header 'Authorization: Access-Token $ROBIN_ACCESS_TOKEN' \
     --header 'accept: application/json'

{
  "meta": {
    "status_code": 200,
    "status": "OK",
    "message": "",
    "more_info": {},
    "errors": []
  },
  "data": [
    {
      "id": 216085,
      "space_id": 203506,
      "name": "Chelsea",
      "type": "pod",
      "created_at": "2022-11-04T08:56:36+0000",
      "updated_at": "2022-11-04T08:56:36+0000"
    },
    {
      "id": 206733,
      "space_id": 203506,
      "name": "Wandsworth ",
      "type": "pod",
      "created_at": "2022-09-14T16:16:17+0000",
      "updated_at": "2022-11-04T08:56:42+0000"
    }
  ],
  "paging": {
    "page": 1,
    "per_page": 10,
    "has_next_page": false
  }
}
```

### Seats

```bash
curl --request GET \
     --url 'https://api.robinpowered.com/v1.0/zones/216085/seats?page=1&per_page=100' \
     --header 'Authorization: Access-Token $ROBIN_ACCESS_TOKEN' \
     --header 'accept: application/json'

# Wandsworth
curl --request GET \
     --url 'https://api.robinpowered.com/v1.0/zones/206733/seats?page=1&per_page=100' \
     --header 'Authorization: Access-Token $ROBIN_ACCESS_TOKEN' \
     --header 'accept: application/json'
```
