version = ENV['HADOOP_VERSION'] || Itamae::Plugin::Recipe::Hadoop::HADOOP_VERSION

execute "download hadoop-#{version}" do
  cwd '/tmp'
  command <<-EOF
    rm -f hadoop-#{version}.tar.gz
    wget https://archive.apache.org/dist/hadoop/common/hadoop-#{version}/hadoop-#{version}.tar.gz
  EOF
  not_if "test -e /opt/hadoop/hadoop-#{version}/INSTALLED || echo #{::File.read(::File.join(::File.dirname(__FILE__), "hadoop-#{version}_sha256.txt")).strip} | sha256sum -c"
end

directory '/opt/hadoop' do
  user 'root'
  owner 'root'
  group 'root'
  mode '755'
end

execute "install hadoop-#{version}" do
  cwd '/tmp'
  command <<-EOF
    rm -Rf hadoop-#{version}/
    tar zxf hadoop-#{version}.tar.gz
    sudo rm -Rf /opt/hadoop/hadoop-#{version}/
    sudo mv hadoop-#{version}/ /opt/hadoop/
    sudo touch /opt/hadoop/hadoop-#{version}/INSTALLED
  EOF
  not_if "test -e /opt/hadoop/hadoop-#{version}/INSTALLED"
end

%W(
  /opt/hadoop/hadoop-#{version}/var/lib/hdfs
  /opt/hadoop/hadoop-#{version}/var/lib/hdfs/name
  /opt/hadoop/hadoop-#{version}/var/lib/hdfs/data
).each do |name|
  directory name do
    user 'root'
    owner ENV['USER']
    group ENV['USER']
  end
end

template "/opt/hadoop/hadoop-#{version}/etc/hadoop/core-site.xml"

template "/opt/hadoop/hadoop-#{version}/etc/hadoop/hdfs-site.xml" do
  variables hadoop_home: "/opt/hadoop/hadoop-#{version}"
end

link '/opt/hadoop/current' do
  to "/opt/hadoop/hadoop-#{version}"
  user 'root'
  force true
end
