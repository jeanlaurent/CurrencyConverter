# Continuous Delivery Training

## Steps

1. Slides
	* WTF is continuous delivery
	* Tools
		* ssh, deploy by hand
		* Jenkins
		* Sonar
		* Deployit
		* Monitoring
	* Deep Dive into the training
1. Explore codebase on (on github tag: ??)
1. Fork repository in github entreprise ( or git clone through vagrant shared directory)
1. Setup in jenkins
	* only `mvn clean install`
	* change git repo url from general to trainee fork
	* Make a build by changing a file like the name of the team in the HEAD tag ( or click a button)
1. Deploy by hand
	* Modifyng shell script
	* deploy by hand by running the script
1. Add Sonar as a new build in the pipeline
1. Deploy with Jenkins
	* Add a specific project in jenkins for deployment (freestyle houhou project)
	* clic on a button
	* glance at the pipeline view
1. Deploy with Puppet
	* Introduce puppet for provisioning ONLY
	* Modify puppet files a bit
	* change jenkins to use puppet
	* clic on a button to deploy
	* Insist on killing an instance an restart it.
1. Modify the code to step2 
	* deploy with puppet
	* introduce deployit
1. Deploy with deployit
	* Make a rollback to see how powerfull it is.
1. Monitoring
	* show a simple moniroting page
	* use some tools to generate traffic on the web page
	* Show the monitoring changes
	* Talk about elastic proviosioning