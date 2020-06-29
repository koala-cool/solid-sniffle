#! /bin/bash
yum update
yum install -y apache2
cat <<EOF > /var/www/html/index.html
<html><body><h1>OiNK</h1>
<p>This page was created from a simple startup script!</p>
</body></html>
EOF