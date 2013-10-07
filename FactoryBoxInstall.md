#Factory Box  Install 
sudo aptitude update

# install various utilities
sudo aptitude install curl, unzip

# install git
sudo aptitude install git
git config --global user.email "someone@sgcib.com"
git config --global user.name "factory"

# install jdk7
sudo aptitude install openjdk-7-jdk

# install maven
curl -O http://mirrors.linsrv.net/apache/maven/maven-3/3.1.0/binaries/apache-maven-3.1.0-bin.tar.gz
sudo tar zxvf apache-maven-3.1.0-bin.tar.gz -C /opt/
cd /opt
sudo ln -s apache-maven-3.1.0 maven
cd
echo "PATH=$PATH:/opt/maven/bin">> '.bashrc' && source .bashrc

# install puppet 3
wget http://apt.puppetlabs.com/puppetlabs-release-precise.deb
sudo dpkg -i puppetlabs-release-precise.deb
sudo aptitude update
sudo aptitude install puppet

# install jenkins
wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo aptitude update
sudo aptitude install jenkins

# install sonarQube
sudo sh -c 'echo deb http://downloads.sourceforge.net/project/sonar-pkg/deb binary/ > /etc/apt/sources.list.d/sonar.list'
sudo aptitude update
sudo aptitude install sonar
sudo service sonar start

# install deployit
scp ~/Desktop/deployit-3.9.2-server.zip vagrant@10.10.10.10:/home/vagrant/
sudo mv deployit-3.9.2-server.zip /opt
sudo unzip deployit-3.9.2-server.zip
sudo rm deployit-3.9.2-server.zip
sudo ln -s deployit-3.9.2-server/ deployit
sudo /opt/deployit/bin/server.sh "Answer Y,Y,N,Y"
CTRL-Z, bg (Yeah, I know...)






