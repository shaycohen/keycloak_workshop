#http://localhost:8080/auth/realms/master/protocol/openid-connect/token
realm='quickstart'

token=$(curl -s -X POST \
    http://localhost:8080/auth/realms/master/protocol/openid-connect/token \
    -H 'Accept: application/json' \
    -H 'Content-Type: application/x-www-form-urlencoded' \
    -H 'cache-control: no-cache' \
    -d 'grant_type=password&username=admin&password=Pa55w0rd&client_id=admin-cli' | jq -r '.access_token')


curl -s -X GET \
    http://localhost:8080/auth/admin/realms/$realm/users \
    -H "Authorization: Bearer $token" \
    -H 'Accept: application/json' \
    -H 'cache-control: no-cache' \
    -H 'Content-Type: application/json' | jq

curl -s -X POST \
    http://localhost:8080/auth/admin/realms/$realm/users \
    -H "Authorization: Bearer $token" \
    -H 'Accept: application/json' \
    -H 'cache-control: no-cache' \
    -H 'Content-Type: application/json' \
    -d '{ 
        "enabled": true, 
        "firstName": "API", 
        "lastName": "User", 
        "username": "api_user"
    }'

userid=$(curl -s -X GET \
    http://localhost:8080/auth/admin/realms/$realm/users \
    -H "Authorization: Bearer $token" \
    -H 'Accept: application/json' \
    -H 'cache-control: no-cache' \
    -H 'Content-Type: application/json' | jq -r '.[] | select (.username == "api_user") | .id')

curl -s -X PUT \
    http://localhost:8080/auth/admin/realms/$realm/users/$userid/reset-password \
    -H "Authorization: Bearer $token" \
    -H 'Accept: application/json' \
    -H 'cache-control: no-cache' \
    -H 'Content-Type: application/json' \
    -d '{
        "value": "pass"
    }'
