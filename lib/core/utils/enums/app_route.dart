enum AppRoute {
  splash('/'),
  offline('/offline'),
  login('/login'),
  registration('/registration'),
  unconfirmed('/unconfirmed'),
  accountSetup('/account-setup'),
  home('/home'),
  createIssue("/create-issue"),
  profile("/profile"),
  issue("/issue"),
  issues("/issues"),
  building("/building"),
  elevator("/elevator");

  final String path;
  const AppRoute(this.path);
}
