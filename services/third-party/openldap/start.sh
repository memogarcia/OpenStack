## Generate root password

# slappasswd -h {SHA} -s 901017
export LDAP_PASSWORD={SHA}YuWSAvQE7gF6Ryl9S9PR23ExhCE=

# DB_CONFIG
cp templates/DB_CONFIG /var/lib/ldap/DB_CONFIG

## DB Configuration db.ldif and ldapmodify
ldapmodify -Y EXTERNAL  -H ldapi:/// -f templates/db.ldif

## monitoring configuration and ldapmodify
ldapmodify -Y EXTERNAL  -H ldapi:/// -f templates/monitor.ldif


ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/cosine.ldif -w {SHA}YuWSAvQE7gF6Ryl9S9PR23ExhCE=

ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/nis.ldif -w {SHA}YuWSAvQE7gF6Ryl9S9PR23ExhCE=

ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/inetorgperson.ldif -w {SHA}YuWSAvQE7gF6Ryl9S9PR23ExhCE=

# Add users and groups?
ldapadd -x -w {SHA}YuWSAvQE7gF6Ryl9S9PR23ExhCE= -D "cn=Manager,dc=openstack,dc=mx" -f templates/base.ldif

# keystone.conf