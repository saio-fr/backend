export default function restrict(req, res, next) {
  if (req.user) {
    next();
  } else {
    res.redirect('/login');
  }
}
