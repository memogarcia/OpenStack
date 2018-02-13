## Generate root password

# slappasswd -h {SHA} -s 901017
export LDAP_PASSWORD={SHA}YuWSAvQE7gF6Ryl9S9PR23ExhCE=

## DB Configuration db.ldif and ldapmodify
ldapmodify -Y EXTERNAL  -H ldapi:/// -f templates/db.ldif

## monitoring configuration and ldapmodify
ldapmodify -Y EXTERNAL  -H ldapi:/// -f templates/monitor.ldif

# DB_CONFIG
cp /usr/share/openldap-servers/DB_CONFIG.example /var/lib/ldap/DB_CONFIG

ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/cosine.ldif -w {SHA}YuWSAvQE7gF6Ryl9S9PR23ExhCE=

ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/nis.ldif -w {SHA}YuWSAvQE7gF6Ryl9S9PR23ExhCE=

ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/inetorgperson.ldif -w {SHA}YuWSAvQE7gF6Ryl9S9PR23ExhCE=

# Add users and groups?
ldapadd -x -w {SHA}YuWSAvQE7gF6Ryl9S9PR23ExhCE= -D "cn=Manager,dc=openstack,dc=mx" -f templates/base.ldif

# keystone.conf