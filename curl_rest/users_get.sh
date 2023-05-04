token=$(curl -s -X POST \
  http://localhost:8080/auth/realms/master/protocol/openid-connect/token \
  -H 'Accept: application/json' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'cache-control: no-cache' \
  -d 'grant_type=password&username=admin&password=Pa55w0rd&client_id=admin-cli' | jq '.access_token' | sed -e 's/^"//; s/"$//')

# get all users of gateway realm, use the token from above and use Bearer as prefix
curl -s -X GET \
  http://localhost:8080/auth/admin/realms/quickstart/users \
  -H "Authorization: Bearer $token" \
  -H 'cache-control: no-cache' | python3 -m json.tool
