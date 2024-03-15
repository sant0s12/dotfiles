let
  # Users
  santos = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINMqYBPKlqUUZpyvSMA4hD5unL4g8758kFmDBsECLTfw";
  userKeys = [ santos ];

  # Systems
  acedia = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINQxJFgx+86ZhdWO7q7DYjEMepRFScKAOwWGsmhHNkui";
  systemKeys = [ acedia ];

  allKeys = userKeys ++ systemKeys;
in
{
  "borgpass.age".publicKeys = allKeys;
  "factorio-token.age".publicKeys = allKeys;
}
