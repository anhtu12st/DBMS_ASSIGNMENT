const knex = require("knex")({
  client: "mysql2",
  connection: {
    host: "127.0.0.1",
    user: "anhtu",
    password: "2001stKh!",
    database: "dbms",
  },
});

module.exports = knex;