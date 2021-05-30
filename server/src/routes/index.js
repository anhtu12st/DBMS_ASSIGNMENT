const router = require('express').Router();

const employeeRoutes = require('./employee.routes');

router.use('/', (req, res) => {
  res.send("Server is running!!!");
})

router.use('/', employeeRoutes);

module.exports = router;
