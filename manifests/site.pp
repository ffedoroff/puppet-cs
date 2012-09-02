node roman-desktop2 {
  rs::cs::developer {$hostname:
    webserver => 'nginx',
  }
}

node roman-desktop {
  rs::cs::developer {$hostname: }
}