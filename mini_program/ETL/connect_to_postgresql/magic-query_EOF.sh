/Applications/Postgres.app/Contents/Versions/15/bin/psql -p5433 <<EOF
\c etl;
SELECT * FROM users;
EOF