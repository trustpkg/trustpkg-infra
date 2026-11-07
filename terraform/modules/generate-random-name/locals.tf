locals {
  dns_names_components = [
    "notmyproblem",
    "worksonthedev",
    "haveyoutriedrebooting",
    "itsalwaysdns",
    "cableunplugged",
    "undefinedbehavior",
    "flapping",
    "dependencyhell",
    "snowflake",
    "worksforme",
    "segfault",
    "kernelpanic",
    "localhost",
    "itworks",
    "rmrf",
    "sudo",
    "permissiondenied",
    "dhcp",
    "dnspropagation",
    "packetloss",
    "blackhole",
    "hairpin",
    "splitbrain",
    "zombieprocess",
    "orphaned",
    "oomkiller",
    "yamlhell",
    "reboot",
    "blameless"
  ]

  dns_random_number = random_integer.dns_number.result
}