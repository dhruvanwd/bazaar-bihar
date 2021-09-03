isUserjson(var profile) {
  print("---------isUserjson----------");
  print(profile);
  return profile['fullName'] != null && profile['role'] != null;
}
