# Configuration for Katello development
class katello_devel::config {

  $apache_version = $::apache::apache_version

  # Required until the katello.yml.erb changes to '@variable' syntax
  include ::katello::params
  file { "${katello_devel::deployment_dir}/foreman/bundler.d/katello.local.rb":
    ensure  => file,
    content => template('katello_devel/katello.local.rb.erb'),
    owner   => $katello_devel::user,
    group   => $katello_devel::group,
    mode    => '0644',
  }

  file { "${katello_devel::deployment_dir}/foreman/config/settings.yaml":
    ensure  => file,
    content => template('katello_devel/settings.yaml.erb'),
    owner   => $katello_devel::user,
    group   => $katello_devel::group,
    mode    => '0644',
  }

  file { "${katello_devel::deployment_dir}/foreman/config/settings.plugins.d":
    ensure => directory,
    owner  => $katello_devel::user,
    group  => $katello_devel::group,
    mode   => '0755',
  } ->
  file { "${katello_devel::deployment_dir}/foreman/config/settings.plugins.d/katello.yaml":
    ensure  => file,
    content => template('katello/katello.yaml.erb'),
    owner   => $katello_devel::user,
    group   => $katello_devel::group,
    mode    => '0644',
  }

  file {'/etc/httpd/conf.d/pulp.conf':
    ensure  => file,
    content => template('katello_devel/pulp.conf.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

}
