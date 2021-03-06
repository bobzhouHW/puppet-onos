class onos::cluster ($controllers_ip) {

$onos_cluster_file_path = $onos::onos_cluster_file_path
$ip1 = $controllers_ip[0]
$ip2 = $controllers_ip[1]
$ip3 = $controllers_ip[2]

exec{ 'sleep 60 for onos service install stable':
        command => 'sudo sleep 60',
		path => "/usr/bin:/usr/sbin:/bin:/sbin"
  }->

## create onos cluster
  exec{ 'create onos cluster':
        command => "/opt/onos/bin/onos-form-cluster $ip1 $ip2 $ip3",
		onlyif => "test ! -f $onos_cluster_file_path",
		path => "/usr/bin:/usr/sbin:/bin:/sbin",
		notify => Notify['onos cluster set up'],
		logoutput => "true"
  }
  notify {'onos cluster set up': }
}