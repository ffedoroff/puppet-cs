; example.com
$TTL    6040
@       IN      SOA     ns1.example.com. root.example.com. (
                     2006020201 ; Serial
                         604800 ; Refresh
                          86400 ; Retry
                        2419200 ; Expire
                         604800); Negative Cache TTL
;
@       IN      NS      ns1
        IN      MX      10 mail
        IN      A       192.0.2.1
ns1     IN      A       192.0.2.1
mail    IN      A       192.0.2.128 ; We have our mail server somewhere else.
www     IN      A       192.0.2.1
client1 IN      A       192.0.2.201 ; We connect to client1 very often.
