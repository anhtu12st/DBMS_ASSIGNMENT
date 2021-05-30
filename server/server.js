const express = require("express");

const routes = require("./src/routes");

// create express app
const app = express();

// Setup server port
const port = process.env.PORT || 5000;

// body-parser
app.use(express.json({ limit: "1MB" }));

// define a root route
app.use("/api/v1", routes);

// listen for requests
app.listen(port, () => {
  console.log(`Server is listening on port ${port}`);
});
