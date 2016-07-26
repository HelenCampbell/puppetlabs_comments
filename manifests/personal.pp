#
define comments::personal(
  $ensure            = 'present',
  $path,
  $filename,
  $comment           = '',

) {
  file { $filename :
    path    => "${path}/${filename}",
    content => "${name} says \"${comment}\"\n",
  }
}
