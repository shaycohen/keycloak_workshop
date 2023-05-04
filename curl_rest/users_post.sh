realm='quickstart'
token=$(curl -s -X POST \
  http://localhost:8080/auth/realms/master/protocol/openid-connect/token \
  -H 'Accept: application/json' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'cache-control: no-cache' \
  -d 'grant_type=password&username=admin&password=Pa55w0rd&client_id=admin-cli' | jq '.access_token' | sed -e 's/^"//; s/"$//')

curl -X POST \
  http://localhost:8080/auth/admin/realms/$realm/users \
  -H 'Content-Type: application/json' \
  -H "Authorization: Bearer $token" \
  -H 'cache-control: no-cache' \
  -d '{
        "enabled": true,
        "firstName": "API",
        "lastName": "User",
        "username": "api_user3"
    }'

id=$(bash users_get.sh | jq -r '.[] | select (.username == "api_user3") | .id')

curl -X PUT \
  http://localhost:8080/auth/admin/realms/$realm/users/$id/reset-password \
  -H 'Content-Type: application/json' \
  -H "Authorization: Bearer $token" \
  -H 'cache-control: no-cache' \
  -d '{
        "value": "pass"
    }'

