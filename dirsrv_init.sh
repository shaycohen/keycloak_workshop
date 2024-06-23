cat << EOF > /data/config/container.inf
[localhost]
# Note that '/' is replaced to '%%2f' for ldapi url format.
# So this is pointing to /data/run/slapd-localhost.socket
uri = ldapi://%%2fdata%%2frun%%2fslapd-localhost.socket
binddn = cn=Directory Manager
# Set your basedn here
# basedn = dc=example,dc=com
basedn = dc=example,dc=com
EOF

URL='ldap://127.0.0.1:3389'
LDAP_USERS='ldap_user4 ldap_user5'
LDAP_PASSW='password'
ldapsearch -H $URL -x -b '' -s base vendorVersion
dsconf localhost backend suffix list
dsconf localhost backend create --suffix dc=example,dc=com --be-name userRoot
/usr/sbin/dsidm localhost initialise
/usr/sbin/dsidm localhost group create --cn test_group
for USER in $LDAP_USERS
do
    /usr/sbin/dsidm localhost user create --uid $USER --cn $USER --displayName $USER --uidNumber 1000 --gidNumber 1000 --homeDirectory /home/$USER
    /usr/sbin/dsidm localhost group add_member test_group uid=$USER,ou=people,dc=example,dc=com
    /usr/sbin/dsidm localhost account reset_password uid=$USER,ou=people,dc=example,dc=com $LDAP_PASSW
    ldapwhoami -H $URL -x -D uid=$USER,ou=people,dc=example,dc=com -w $LDAP_PASSW
done
ldapsearch -H $URL -x -b 'dc=example,dc=com'

