const jwt = require("jsonwebtoken");
const SECRET_KEY = "NBAAPI";
const auth = (req, res, next) => {
  let token = req.headers.authorization;
  if (!token) return res.status(401).json({ error: "auth token not present" });
  token = token.split(" ")[1];
  jwt.verify(token, SECRET_KEY, (err, payload) => {
    if (err) return res.status(401).json({ error: err.message });
    req.userId = payload.id;
    console.log(req.userId);

    next();
  });
  
};

module.exports = auth;
