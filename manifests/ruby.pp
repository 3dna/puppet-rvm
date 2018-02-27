define rvm::ruby (
  $user,
  $version
) {

  single_user_rvm::install_ruby { "ruby-${version}-for-${user}":
    user => $user,
    ruby_string => $version,
    require => [Single_User_Rvm::Install[$user]]
  }

}
