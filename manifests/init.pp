# == Class: role_elasticsearch
#
#
class role_elasticsearch (
  $package_url = 'https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/deb/elasticsearch/2.4.0/elasticsearch-2.4.0.deb',
  $clustername = 'cluster-01',
  $replicas    = '0',
  $shards      = '1',
) {

  class { 'elasticsearch':
    package_url  => $package_url,
    java_install => true,
    config       => { 'cluster.name'             => $clustername,
                      'index.number_of_shards'   => $shards,
                      'index.number_of_replicas' => $replicas,
                    },
  }

  # Create instance
  elasticsearch::instance { 'es-01':
  }

  # Install kopf plugin
  elasticsearch::plugin { 'lmenezes/elasticsearch-kopf':
    instances  => 'es-01'
  }

}
