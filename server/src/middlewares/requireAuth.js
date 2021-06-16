const UserModel = require("./models/User.model");

exports.requireAuth = async (req, res, next) => {
  let token = req.headers.authorization;
  if (!token)
    return res.status(401).json({ message: "Authentication invalid." });

  try {
    token = token.split("-");
    const username = token[0];
    const password = token[1];
    const data = await UserModel.find({ username, password });

    if (data.length === 0)
      return res.status(403).json({ message: "Unauthorized." });

    req.user = data[0];
    next();
  } catch (error) {
    return res.status(401).json({
      message: error.message,
    });
  }
};
