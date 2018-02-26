define rvm::bash_exec (
  $command = $name,
  $user,
  $creates = undef,
  $cwd = undef,
  $environment = undef,
  $group = undef,
  $logoutput = undef,
  $onlyif = undef,
  $path = undef,
  $provider = "posix",
  $refresh = undef,
  $refreshonly = undef,
  $returns = undef,
  $ruby_version = undef,
  $timeout = undef,
  $tries = undef,
  $try_sleep = undef,
  $umask = undef,
  $unless = undef
) {
  if $cwd == undef {
    $command_cwd_prefix = ""
  } else {
    $command_cwd_prefix = "cd ${cwd} && "
  }

  if $ruby_version == undef {
    $command_ruby_prefix = ""
  } else {
    $command_ruby_prefix = "rvm ${ruby_version} do "
  }

  $command_prefix = join($command_cwd_prefix, $command_ruby_prefix)

  $escaped_command = join(["/bin/su -l ${user} -c ", shellquote(join(['/bin/bash --login -c ', shellquote(join([$command_prefix, $command], ""))], ""))], "")

  if $unless == undef {
    $escaped_unless = undef
  } else {
    $escaped_unless = join(["/bin/su -l ${user} -c ", shellquote(join(['/bin/bash --login -c ', shellquote(join([$command_prefix, $unless], ""))], ""))], "")
  }

  if $onlyif == undef {
    $escaped_onlyif = undef
  } else {
    $escaped_onlyif = join(["/bin/su -l ${user} -c ", shellquote(join(['/bin/bash --login -c ', shellquote(join([$command_prefix, $onlyif], ""))], ""))], "")
  }

  exec { $name:
    command => $escaped_command,
    creates => $creates,
    cwd => $cwd,
    environment => $environment,
    group => $group,
    logoutput => $logoutput,
    onlyif => $escaped_onlyif,
    path => $path,
    provider => $provider,
    refresh => $refresh,
    refreshonly => $refreshonly,
    returns => $returns,
    timeout => $timeout,
    tries => $tries,
    try_sleep => $try_sleep,
    umask => $umask,
    unless => $escaped_unless
  }
}
