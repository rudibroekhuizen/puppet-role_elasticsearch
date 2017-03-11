# == Class: role_elasticsearch
#
#
class role_elasticsearch (
  $package_url = 'https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.2.0.deb',
  $clustername = 'cluster-01',
) {

  # Install Java
  package { 'openjdk-8-jdk': }

  class { 'elasticsearch':
    package_url  => $package_url,
    config       => { 'cluster.name' => $clustername,
                    },
  }

  # Create instance
  elasticsearch::instance { 'es-01':
  }

  # Install kopf plugin
  #elasticsearch::plugin { 'lmenezes/elasticsearch-kopf':
  #  instances  => 'es-01'
  #}

}
